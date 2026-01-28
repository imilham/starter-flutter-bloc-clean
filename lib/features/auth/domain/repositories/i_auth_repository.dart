import 'package:starter/core/core.dart';
import 'package:starter/features/auth/domain/entities/entities.dart';

/// Abstract repository interface for authentication operations.
///
/// This defines the contract that data layer must implement.
/// Domain layer only knows about this interface, not the implementation.
abstract interface class IAuthRepository {
  /// Logs in a user with email and password.
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
    required String deviceId,
    required String deviceType,
    String? devicePushToken,
  });

  /// Registers a new user.
  Future<Result<AuthSession>> register({
    required String email,
    required String password,
    required String deviceId,
    required String deviceType,
    String? devicePushToken,
  });

  /// Logs out the current user.
  Future<Result<void>> logout({required String token});

  /// Verifies the user's email with a code.
  Future<Result<AuthSession>> verifyEmail({
    required String code,
    required String token,
  });

  /// Resends the verification code.
  Future<Result<void>> resendVerificationCode({required String token});

  /// Sends a forgot password request.
  Future<Result<void>> forgotPassword({required String email});

  /// Gets the current session from local storage.
  Future<AuthSession?> getStoredSession();

  /// Saves the session to local storage.
  Future<void> saveSession(AuthSession session);

  /// Deletes the stored session.
  Future<void> deleteSession();
}
