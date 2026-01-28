import 'package:starter/features/auth/data/models/models.dart';

/// Remote data source for authentication operations.
///
/// This handles all API calls related to authentication.
abstract interface class AuthRemoteDataSource {
  /// Logs in a user with email and password.
  Future<AuthSessionModel> login({
    required String email,
    required String password,
    required String deviceId,
    required String deviceType,
    String? devicePushToken,
  });

  /// Registers a new user.
  Future<AuthSessionModel> register({
    required String email,
    required String password,
    required String deviceId,
    required String deviceType,
    String? devicePushToken,
  });

  /// Logs out the current user.
  Future<void> logout({required String token});

  /// Verifies the user's email with a code.
  Future<AuthSessionModel> verifyEmail({
    required String code,
    required String token,
  });

  /// Resends the verification code.
  Future<void> resendVerificationCode({required String token});

  /// Sends a forgot password request.
  Future<void> forgotPassword({required String email});
}
