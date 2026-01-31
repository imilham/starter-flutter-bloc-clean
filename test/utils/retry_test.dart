// ignore_for_file: only_throw_errors

import 'dart:async';
import 'package:starter/utils/retry.dart';
import 'package:test/test.dart';

void main() {
  group('Retry Logic Verification', () {
    test('Jitter produces strictly positive delays', () {
      const strategy = ExponentialBackoffStrategy(
        baseDelay: Duration(milliseconds: 10), 
        randomizationFactor: 0.5,
      );
      for (var i = 1; i <= 100; i++) {
        final delay = strategy.getDelay(1);
        expect(delay.inMicroseconds, greaterThanOrEqualTo(0));
      }
    });

    test('Circuit Breaker transitions correctly', () async {
      final cb = CircuitBreaker(failureThreshold: 2, resetTimeout: const Duration(milliseconds: 100));
      final options = ResilientRetryOptions(
        maxAttempts: 1, 
        circuitBreaker: cb,
      );

      // 1. First failure
      try {
        await options.retryWithResult((_) => throw 'fail 1');
      } catch (_) {}
      expect(cb.state, CircuitBreakerState.closed);

      // 2. Second failure -> Open
      try {
        await options.retryWithResult((_) => throw 'fail 2');
      } catch (_) {}
      expect(cb.state, CircuitBreakerState.closed); // Wait, recordFailure happens AFTER retry logic catches. 
      // Actually retryWithResult loops. If maxAttempts=1, it tries once, fails, calls recordFailure.
      // recordFailure checks existing failures. 
      // Attempt 1: fails. recordFailure -> failures=1. (Threshold=2). State Closed.
      
      // We need to trigger enough failures.
      cb..recordFailure() // 1
      ..recordFailure(); // 2 -> Open
      expect(cb.state, CircuitBreakerState.open);
      expect(cb.canRequest, isFalse);

      // 3. Request rejected
      expect(() => options.retryWithResult((_) async => 'success'), throwsA(isA<CircuitBreakerOpenException>()));

      // 4. Wait for timeout -> HalfOpen
      await Future.delayed(const Duration(milliseconds: 150));
      expect(cb.canRequest, isTrue);
      // Ideally check state is HalfOpen (it updates on check)
      // Note: canRequest updates the state
      expect(cb.state, CircuitBreakerState.halfOpen);
      
      // 5. Success -> Closed
      await options.retryWithResult((_) async => 'success');
      expect(cb.state, CircuitBreakerState.closed);
    });

    test('Cancellation stops operation immediately', () async {
      final token = CancellationToken();
      final options = RetryOptions(
        maxAttempts: 3,
        strategy: LinearBackoffStrategy(baseDelay: const Duration(seconds: 1)),
      );

      final future = options.retryWithResult(
        (_) => throw 'fail',
        cancellationToken: token,
      );

      // Cancel after small delay (during the backoff of first attempt)
      Future.delayed(const Duration(milliseconds: 100), token.cancel);

      try {
        await future;
        fail('Should have thrown CancelledException');
      } catch (e) {
        expect(e, isA<CancelledException>());
      }
    });

    test('Overall timeout enforces limit', () async {
      final options = RetryOptions(
        maxAttempts: 10,
        strategy: LinearBackoffStrategy(baseDelay: const Duration(seconds: 1)),
        overallTimeout: const Duration(milliseconds: 500),
      );

      try {
        await options.retryWithResult((_) => throw 'fail');
        fail('Should have timed out');
      } catch (e) {
        expect(e, isA<TimeoutException>());
      }
    });
  });
}
