import 'package:starter/core/core.dart';
import 'package:starter/features/auth/domain/entities/entities.dart';
import 'package:starter/features/auth/domain/repositories/repositories.dart';

/// Use case for getting the stored session.
class GetStoredSessionUseCase implements UseCase<AuthSession?, NoParams> {
  const GetStoredSessionUseCase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Result<AuthSession?>> call(NoParams params) async {
    final session = await _repository.getStoredSession();
    return Result.success(session);
  }
}
