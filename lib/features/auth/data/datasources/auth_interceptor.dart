import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/utils/utils.dart';

/// Interceptor that adds authentication token to requests.
///
/// This interceptor retrieves the current session from Hive storage
/// and adds the access token to the request headers.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({this.rejectIfNoSession = false});

  final bool rejectIfNoSession;
  final Box<String> _storage = Hive.box<String>(GetIt.instance<AppSettings>().sessionSecretKey);

  Future<AuthSession?> getCurrentSession() async {
    final session = _storage.get('session');
    if (session == null) {
      return null;
    }
    return AuthSessionModel.fromJson(jsonDecode(session) as Map<String, dynamic>);
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final session = await getCurrentSession();
    if (session == null && rejectIfNoSession) {
      handler.reject(DioException(requestOptions: options, error: 'No session found, please login.'));
    } else if (session != null) {
      options.headers['x-access-token'] = session.accessToken;
    }
    super.onRequest(options, handler);
  }
}
