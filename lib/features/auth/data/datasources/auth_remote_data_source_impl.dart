import 'package:starter/features/auth/auth.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AuthSessionModel> login({
    required String email,
    required String password,
    required String deviceId,
    required String deviceType,
    String? devicePushToken,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (email == 'user@example.com' && password == 'password') {
      return AuthSessionModel(
        accessToken: 'mock_token',
        userId: '1',
        createdAt: DateTime.now(),
        isProfileCompleted: true,
      );
    }
    // For now always return success for dev
    return AuthSessionModel(
      accessToken: 'mock_token',
      userId: '1',
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<AuthSessionModel> register({
    required String email,
    required String password,
    required String deviceId,
    required String deviceType,
    String? devicePushToken,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return AuthSessionModel(
      accessToken: 'mock_token',
      userId: '1',
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<void> logout({required String token}) async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  @override
  Future<AuthSessionModel> verifyEmail({required String code, required String token}) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return AuthSessionModel(
      accessToken: 'mock_token_verified',
      userId: '1',
      createdAt: DateTime.now(),
      isEmailVerified: true,
    );
  }

  @override
  Future<void> resendVerificationCode({required String token}) async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }
}
