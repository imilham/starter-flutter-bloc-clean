/// Abstract base class for all failures in the application.
///
/// Extend this class to create specific failure types.
abstract class Failure {
  const Failure(this.message);

  /// Human-readable error message.
  final String message;

  @override
  String toString() => message;
}

/// Failure caused by server/API errors.
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

/// Failure caused by network connectivity issues.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

/// Failure caused by cache/local storage errors.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

/// Failure caused by invalid input or validation errors.
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed']);
}

/// Failure caused by authentication errors.
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);
}
