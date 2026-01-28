import 'package:starter/core/core.dart';
import 'package:starter/features/auth/domain/repositories/repositories.dart';

/// Use case for logging out the current user.
class LogoutUseCase implements UseCase<void, LogoutParams> {
  const LogoutUseCase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Result<void>> call(LogoutParams params) async {
    final result = await _repository.logout(token: params.token);
    if (result.isSuccess) {
      await _repository.deleteSession();
    }
    return result;
  }
}

/// Parameters for [LogoutUseCase].
class LogoutParams {
  const LogoutParams({required this.token});

  final String token;
}
