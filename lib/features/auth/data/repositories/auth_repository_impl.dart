import 'package:starter/core/core.dart';
import 'package:starter/features/auth/data/datasources/datasources.dart';
import 'package:starter/features/auth/data/models/models.dart';
import 'package:starter/features/auth/domain/entities/entities.dart';
import 'package:starter/features/auth/domain/repositories/repositories.dart';

/// Implementation of [IAuthRepository].
///
/// This coordinates between remote and local data sources.
class AuthRepositoryImpl implements IAuthRepository {
  AuthRepositoryImpl({
    required this.localDataSource, this.remoteDataSource,
  });

  final AuthRemoteDataSource? remoteDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
    required String deviceId,
    required String deviceType,
    String? devicePushToken,
  }) async {
    final remote = remoteDataSource;
    if (remote == null) {
      return const Result.failure(ServerFailure('Remote data source not configured'));
    }
    try {
      final result = await remote.login(
        email: email,
        password: password,
        deviceId: deviceId,
        deviceType: deviceType,
        devicePushToken: devicePushToken,
      );
      await localDataSource.saveSession(result);
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<AuthSession>> register({
    required String email,
    required String password,
    required String deviceId,
    required String deviceType,
    String? devicePushToken,
  }) async {
    final remote = remoteDataSource;
    if (remote == null) {
      return const Result.failure(ServerFailure('Remote data source not configured'));
    }
    try {
      final result = await remote.register(
        email: email,
        password: password,
        deviceId: deviceId,
        deviceType: deviceType,
        devicePushToken: devicePushToken,
      );
      await localDataSource.saveSession(result);
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> logout({required String token}) async {
    final remote = remoteDataSource;
    if (remote != null) {
      try {
        await remote.logout(token: token);
      } on Exception catch (e) {
        // Log but don't fail - local logout should still proceed
        // ignore: avoid_print
        print('Remote logout failed: $e');
      }
    }
    await localDataSource.deleteSession();
    return const Result.success(null);
  }

  @override
  Future<Result<AuthSession>> verifyEmail({
    required String code,
    required String token,
  }) async {
    final remote = remoteDataSource;
    if (remote == null) {
      return const Result.failure(ServerFailure('Remote data source not configured'));
    }
    try {
      final result = await remote.verifyEmail(code: code, token: token);
      await localDataSource.saveSession(result);
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> resendVerificationCode({required String token}) async {
    final remote = remoteDataSource;
    if (remote == null) {
      return const Result.failure(ServerFailure('Remote data source not configured'));
    }
    try {
      await remote.resendVerificationCode(token: token);
      return const Result.success(null);
    } on Exception catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> forgotPassword({required String email}) async {
    final remote = remoteDataSource;
    if (remote == null) {
      return const Result.failure(ServerFailure('Remote data source not configured'));
    }
    try {
      await remote.forgotPassword(email: email);
      return const Result.success(null);
    } on Exception catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<AuthSession?> getStoredSession() async {
    return localDataSource.getSession();
  }

  @override
  Future<void> saveSession(AuthSession session) async {
    await localDataSource.saveSession(AuthSessionModel.fromEntity(session));
  }

  @override
  Future<void> deleteSession() async {
    await localDataSource.deleteSession();
  }
}
