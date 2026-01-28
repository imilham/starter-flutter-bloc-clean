import 'package:equatable/equatable.dart';
import 'package:starter/core/core.dart';
import 'package:starter/features/auth/domain/entities/entities.dart';
import 'package:starter/features/auth/domain/repositories/repositories.dart';

/// Use case for verifying email with a code.
class VerifyEmailUseCase implements UseCase<AuthSession, VerifyEmailParams> {
  const VerifyEmailUseCase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Result<AuthSession>> call(VerifyEmailParams params) {
    return _repository.verifyEmail(code: params.code, token: params.token);
  }
}

/// Parameters for [VerifyEmailUseCase].
class VerifyEmailParams extends Equatable {
  const VerifyEmailParams({
    required this.code,
    required this.token,
  });

  final String code;
  final String token;

  @override
  List<Object?> get props => [code, token];
}
