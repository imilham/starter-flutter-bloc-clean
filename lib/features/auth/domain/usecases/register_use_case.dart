import 'package:equatable/equatable.dart';
import 'package:starter/core/core.dart';
import 'package:starter/features/auth/auth.dart';

/// Use case for registering a new user.
class RegisterUseCase implements UseCase<AuthSession, RegisterParams> {
  const RegisterUseCase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Result<AuthSession>> call(RegisterParams params) {
    return _repository.register(
      email: params.email,
      password: params.password,
      deviceId: params.deviceId,
      deviceType: params.deviceType,
      devicePushToken: params.devicePushToken,
    );
  }
}

/// Parameters for [RegisterUseCase].
class RegisterParams extends Equatable {
  const RegisterParams({
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
