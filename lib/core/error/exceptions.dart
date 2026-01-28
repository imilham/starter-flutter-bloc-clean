/// Exception thrown when a server request fails.
///
/// Data sources throw these exceptions, and repositories catch them
/// to convert into Failure objects.
class ServerException implements Exception {
  const ServerException([this.message = 'Server error']);
  final String message;

  @override
  String toString() => message;
}

/// Exception thrown when there is no network connection.
class NetworkException implements Exception {
  const NetworkException([this.message = 'No internet connection']);
  final String message;

  @override
  String toString() => message;
}

/// Exception thrown when cache operations fail.
class CacheException implements Exception {
  const CacheException([this.message = 'Cache error']);
  final String message;

  @override
  String toString() => message;
}

/// Exception thrown when authentication fails.
class AuthException implements Exception {
  const AuthException([this.message = 'Authentication failed']);
  final String message;

  @override
  String toString() => message;
}
