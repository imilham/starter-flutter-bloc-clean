import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
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

  // Lazy getter to avoid accessing Hive box before it's opened
  Box<String> get _storage => Hive.box<String>(GetIt.instance<AppSettings>().sessionSecretKey);

  // ============================================================================
  // Public endpoints that don't require authentication
  // Add new public endpoints here as your API grows
  // ============================================================================
  final List<String> _publicEndpoints = [
    '/auth/login',
    '/auth/register',
    '/auth/forgot-password',
  ];

  /// Checks if the given path is a public endpoint
  bool _isPublicEndpoint(String path) {
    return _publicEndpoints.any((endpoint) => path.contains(endpoint));
  }

  /// Retrieves the current user session from Hive storage
  Future<AuthSession?> getCurrentSession() async {
    final session = _storage.get('session');
    if (session == null) return null;
    return AuthSessionModel.fromJson(jsonDecode(session) as Map<String, dynamic>);
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
    }

    super.onRequest(options, handler);
  }
}
