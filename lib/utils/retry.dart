import 'dart:async';
import 'dart:math' as math;

// TODO(ishanga): Add comprehensive logging and metrics support throughout the retry system
// Consider integrating with structured logging frameworks for better observability
// Implement memory optimization for long-running retry operations
// Large attempt histories could consume significant memory in high-throughput scenarios
// Add more retry strategy implementations (fixed delay, custom strategies)
// Consider strategies like fibonacci backoff, polynomial backoff, etc.
// Enhance error type system with specific retry-related exceptions
// Create a hierarchy of exceptions for different retry failure scenarios

/// Base class for retry strategies
// ignore: one_member_abstracts
abstract class RetryStrategy {
  Duration getDelay(int attempt);
}

/// Exponential backoff strategy with jitter
class ExponentialBackoffStrategy implements RetryStrategy {
  const ExponentialBackoffStrategy({
    this.baseDelay = const Duration(milliseconds: 200),
    this.randomizationFactor = 0.25,
    this.maxDelay = const Duration(seconds: 30),
    this.random,
  });

  final Duration baseDelay;
  final double randomizationFactor;
  final Duration maxDelay;
  final math.Random? random;

  @override
  Duration getDelay(int attempt) {
    if (attempt <= 0) return Duration.zero;

    final randomGenerator = random ?? math.Random();
    
    // Fixed jitter implementation to ensure positive multiplier
    // Generates a value in range [1 - randomizationFactor, 1 + randomizationFactor]
    // Clamped to be at least 0.0 to prevent negative delays
    final rf = randomizationFactor * (randomGenerator.nextDouble() * 2 - 1) + 1;
    final validRf = math.max(0, rf);
    
    final exp = math.min(attempt, 31);
    final delay = baseDelay * math.pow(2.0, exp) * validRf;
    return delay < maxDelay ? delay : maxDelay;
  }
}

/// Linear backoff strategy
class LinearBackoffStrategy implements RetryStrategy {
  LinearBackoffStrategy({
    this.baseDelay = const Duration(milliseconds: 500),
    this.maxDelay = const Duration(seconds: 30),
  });

  final Duration baseDelay;
  final Duration maxDelay;

  @override
  Duration getDelay(int attempt) {
    if (attempt <= 0) return Duration.zero;
    // TODO(ishanga): Add overflow protection for large attempt values
    final delay = baseDelay * attempt;
    return delay < maxDelay ? delay : maxDelay;
  }
}

/// Result of a retry operation
class RetryResult<T> {
  RetryResult({
    required this.value,
    required this.attempts,
    required this.totalDuration,
    required this.attemptHistory,
  });

  final T value;
  final int attempts;
  final Duration totalDuration;
  final List<RetryAttempt> attemptHistory;
}

/// Information about a single retry attempt
class RetryAttempt {
  RetryAttempt({
    required this.attemptNumber,
    required this.timestamp,
    required this.duration,
    required this.succeeded,
    this.error,
  });

  final int attemptNumber;
  final DateTime timestamp;
  final Duration duration;
  final Object? error;
  final bool succeeded;
}

/// Enhanced retry options with more features
class RetryOptions {
  const RetryOptions({
    this.strategy = const ExponentialBackoffStrategy(),
    this.maxAttempts = 8,
    this.timeoutPerAttempt,
    this.overallTimeout,
    this.operationName,
  }) : assert(maxAttempts > 0, 'maxAttempts must be positive');

  final RetryStrategy strategy;
  final int maxAttempts;
  final Duration? timeoutPerAttempt;
  final Duration? overallTimeout;
  final String? operationName;

  /// Retry with enhanced error handling and cancellation support
  Future<RetryResult<T>> retryWithResult<T>(
    FutureOr<T> Function(int attempt) fn, {
    FutureOr<bool> Function(Object)? retryIf,
    FutureOr<void> Function(Object, int)? onRetry,
    FutureOr<void> Function(RetryResult<T>)? onSuccess,
    CancellationToken? cancellationToken,
  }) async {
    final startTime = DateTime.now();
    final attemptHistory = <RetryAttempt>[];
    var attempt = 0;

    while (attempt < maxAttempts) {
      cancellationToken?.throwIfCancelled();

      // Check overall timeout
      if (overallTimeout != null && DateTime.now().difference(startTime) > overallTimeout!) {
        throw TimeoutException('Overall retry operation timed out', overallTimeout);
      }

      attempt++;
      final attemptStart = DateTime.now();

      try {
        final future = fn(attempt);
        // TODO(ishanga): Improve timeout handling - consider per-operation timeout vs cumulative timeout
        // Current implementation only handles per-attempt timeout, not total operation timeout
        final result = timeoutPerAttempt != null ? await Future.value(future).timeout(timeoutPerAttempt!) : await future;

        final duration = DateTime.now().difference(attemptStart);
        attemptHistory.add(
          RetryAttempt(
            attemptNumber: attempt,
            timestamp: attemptStart,
            duration: duration,
            succeeded: true,
          ),
        );

        final retryResult = RetryResult(
          value: result,
          attempts: attempt,
          totalDuration: DateTime.now().difference(startTime),
          attemptHistory: attemptHistory,
        );

        if (onSuccess != null) {
          await onSuccess(retryResult);
        }

        return retryResult;
      } catch (e, stackTrace) {
        final attemptDuration = DateTime.now().difference(attemptStart);
        attemptHistory.add(
          RetryAttempt(
            attemptNumber: attempt,
            timestamp: attemptStart,
            duration: attemptDuration,
            error: e,
            succeeded: false,
          ),
        );

        final shouldRetry = retryIf == null || await retryIf(e);

        if (!shouldRetry || attempt >= maxAttempts) {
          // TODO(ishanga): Enhance error context - include retry history and operation details in final error
          // Consider wrapping original error with retry context information
          // Preserve the original error type, but doing this will require careful handling
          // when comparing errors in retryIf function
          if (e is Error) {
            Error.throwWithStackTrace(e, stackTrace);
          } else {
            rethrow;
          }
        }

        if (onRetry != null) {
          await onRetry(e, attempt);
        }

        if (attempt < maxAttempts) {
          final delay = strategy.getDelay(attempt);
          
          if (cancellationToken != null) {
            // Support cancellation during delay
            await Future.any([
              Future<void>.delayed(delay),
              cancellationToken.cancelled,
            ]);
            cancellationToken.throwIfCancelled();
          } else {
            await Future<void>.delayed(delay);
          }
        }
      }
    }

    // This should never be reached
    throw StateError('Retry loop ended unexpectedly');
  }
}

/// Cancellation token for retry operations
class CancellationToken {
  bool _isCancelled = false;
  final _completer = Completer<void>();

  bool get isCancelled => _isCancelled;
  Future<void> get cancelled => _completer.future;

  void cancel() {
    if (!_isCancelled) {
      _isCancelled = true;
      _completer.complete();
    }
  }

  void throwIfCancelled() {
    if (_isCancelled) {
      throw CancelledException();
    }
  }
}

class CancelledException implements Exception {
  @override
  String toString() => 'Operation was cancelled';
}

enum CircuitBreakerState {
  closed,
  open,
  halfOpen,
}

/// Circuit breaker for preventing retry storms
class CircuitBreaker {
  CircuitBreaker({
    this.failureThreshold = 5,
    this.resetTimeout = const Duration(minutes: 1),
  });

  final int failureThreshold;
  final Duration resetTimeout;

  int _consecutiveFailures = 0;
  DateTime? _lastFailureTime;
  CircuitBreakerState _state = CircuitBreakerState.closed;

  // TODO(ishanga): Add thread safety considerations for isolate usage
  // Consider using atomic operations or synchronization primitives
  
  bool get canRequest {
    if (_state == CircuitBreakerState.open) {
      if (_lastFailureTime != null && 
          DateTime.now().difference(_lastFailureTime!) > resetTimeout) {
        _state = CircuitBreakerState.halfOpen;
        return true;
      }
      return false;
    }
    return true;
  }

  void recordSuccess() {
    _consecutiveFailures = 0;
    _state = CircuitBreakerState.closed;
    _lastFailureTime = null;
  }

  void recordFailure() {
    _consecutiveFailures++;
    _lastFailureTime = DateTime.now();

    if (_state == CircuitBreakerState.halfOpen || _consecutiveFailures >= failureThreshold) {
      _state = CircuitBreakerState.open;
    }
  }

  void reset() {
    _consecutiveFailures = 0;
    _state = CircuitBreakerState.closed;
    _lastFailureTime = null;
  }
  
  // For testing/monitoring
  CircuitBreakerState get state => _state;
}

/// Enhanced retry with circuit breaker
class ResilientRetryOptions extends RetryOptions {
  const ResilientRetryOptions({
    super.strategy,
    super.maxAttempts,
    super.timeoutPerAttempt,
    super.overallTimeout,
    super.operationName,
    this.circuitBreaker,
  });

  final CircuitBreaker? circuitBreaker;

  @override
  Future<RetryResult<T>> retryWithResult<T>(
    FutureOr<T> Function(int attempt) fn, {
    FutureOr<bool> Function(Object)? retryIf,
    FutureOr<void> Function(Object, int)? onRetry,
    FutureOr<void> Function(RetryResult<T>)? onSuccess,
    CancellationToken? cancellationToken,
  }) async {
    if (circuitBreaker != null && !circuitBreaker!.canRequest) {
      throw CircuitBreakerOpenException();
    }

    try {
      final result = await super.retryWithResult(
        fn,
        retryIf: retryIf,
        onRetry: (e, attempt) async {
          circuitBreaker?.recordFailure();
          if (onRetry != null) {
            await onRetry(e, attempt);
          }
        },
        onSuccess: onSuccess,
        cancellationToken: cancellationToken,
      );

      circuitBreaker?.recordSuccess();
      return result;
    } catch (e) {
      // If we caught an exception from super.retryWithResult, it means all retries failed
      // or a non-retriable error occurred.
      // Note: failures *during* attempts are handled by onRetry wrapper above.
      // This catch block handles the final exception.
      // However, onRetry is called for *each* failure. 
      // If the final failure happens, recordFailure was already called.
      // But if it's a non-retriable error that bypassed onRetry?
      // Best to ensure we record failure if we haven't.
      
      // Let's rely on onRetry for intermediate failures. 
      // If the circuit breaker sees consecutive failures via onRetry, it opens.
      rethrow;
    }
  }
}

class CircuitBreakerOpenException implements Exception {
  @override
  String toString() => 'Circuit breaker is open - too many consecutive failures';
}
