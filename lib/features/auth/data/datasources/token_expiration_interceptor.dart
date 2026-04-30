import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/features/auth/auth.dart';

/// Interceptor that handles 401 Unauthorized errors by logging the user out.
class TokenExpirationInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('🚨 TokenExpirationInterceptor: Caught error ${err.response?.statusCode}');
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      debugPrint('🚨 TokenExpirationInterceptor: Dispatching AuthLogoutRequested');
      // Lazy load AuthBloc to avoid circular dependency
      // Dispatch logout with a session expired message
      getIt<AuthBloc>().add(
        const AuthLogoutRequested(message: 'Session expired. Please login again.'),
      );
    }
    super.onError(err, handler);
  }
}
