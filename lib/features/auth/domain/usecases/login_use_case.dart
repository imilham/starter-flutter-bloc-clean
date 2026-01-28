import 'package:equatable/equatable.dart';
import 'package:starter/core/core.dart';
import 'package:starter/features/auth/domain/entities/entities.dart';
import 'package:starter/features/auth/domain/repositories/repositories.dart';

/// Use case for logging in a user.
class LoginUseCase implements UseCase<AuthSession, LoginParams> {
  const LoginUseCase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Result<AuthSession>> call(LoginParams params) {
    return _repository.login(
      email: params.email,
      password: params.password,
      deviceId: params.deviceId,
      deviceType: params.deviceType,
      devicePushToken: params.devicePushToken,
    );
  }
}

/// Parameters for [LoginUseCase].
class LoginParams extends Equatable {
  const LoginParams({
    required this.email,
    required this.password,
    required this.deviceId,
    required this.deviceType,
    this.devicePushToken,
  });

  final String email;
  final String password;
  final String deviceId;
  final String deviceType;
  final String? devicePushToken;

  @override
  List<Object?> get props => [email, password, deviceId, deviceType, devicePushToken];
}
