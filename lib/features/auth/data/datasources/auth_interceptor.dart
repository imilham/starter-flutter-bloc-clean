import 'package:starter/features/auth/auth.dart';
import 'package:starter/utils/utils.dart';

/// Smart interceptor that automatically adds authentication tokens to requests.
///
/// This interceptor:
/// - Whitelists public endpoints (login, register, forgot-password)
/// - Automatically adds auth token to all other endpoints
/// - Retrieves session from Hive storage
class AuthInterceptor extends Interceptor {
  AuthInterceptor({this.rejectIfNoSession = false});

  final bool rejectIfNoSession;

  /// Lazily retrieve AuthLocalDataSource to avoid circular dependency issues
  /// during DI initialization (Network Module initializes before Auth Module).
  AuthLocalDataSource get _authLocalDataSource => GetIt.instance<AuthLocalDataSource>();

  // ============================================================================
  // Public endpoints that don't require authentication
  // Add new public endpoints here as your API grows
  // ============================================================================
  final List<String> _publicEndpoints = [
    '/login',
    '/register',
    '/forgot-password',
  ];

  /// Checks if the given path is a public endpoint
  bool _isPublicEndpoint(String path) {
    return _publicEndpoints.any(
      (endpoint) => path == endpoint || path.endsWith(endpoint),
    );
  }

  /// Retrieves the current user session
  Future<AuthSessionModel?> getCurrentSession() async {
    return _authLocalDataSource.getSession();
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Skip authentication for public endpoints
    if (_isPublicEndpoint(options.path)) {
      return super.onRequest(options, handler);
    }

    // For protected endpoints, add authentication token
    final session = await getCurrentSession();

    if (session == null && rejectIfNoSession) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'No session found, please login.',
        ),
      );
    } else if (session != null) {
      // Add token to request headers
      options.headers['x-access-token'] = session.accessToken;
      // options.headers['x-access-token'] = '${session.accessToken}_INVALID';
    }

    super.onRequest(options, handler);
  }
}
