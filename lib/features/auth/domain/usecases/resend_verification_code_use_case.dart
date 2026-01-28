import 'package:equatable/equatable.dart';
import 'package:starter/core/core.dart';
import 'package:starter/features/auth/domain/repositories/repositories.dart';

/// Use case for resending the verification code.
class ResendVerificationCodeUseCase implements UseCase<void, ResendVerificationCodeParams> {
  const ResendVerificationCodeUseCase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Result<void>> call(ResendVerificationCodeParams params) {
    return _repository.resendVerificationCode(token: params.token);
  }
}

/// Parameters for [ResendVerificationCodeUseCase].
class ResendVerificationCodeParams extends Equatable {
  const ResendVerificationCodeParams({required this.token});

  final String token;

  @override
  List<Object?> get props => [token];
}
