import 'package:equatable/equatable.dart';
import 'package:starter/core/core.dart';
import 'package:starter/features/auth/domain/repositories/repositories.dart';

/// Use case for sending a forgot password request.
class ForgotPasswordUseCase implements UseCase<void, ForgotPasswordParams> {
  const ForgotPasswordUseCase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Result<void>> call(ForgotPasswordParams params) {
    return _repository.forgotPassword(email: params.email);
  }
}

/// Parameters for [ForgotPasswordUseCase].
class ForgotPasswordParams extends Equatable {
  const ForgotPasswordParams({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}
