import 'package:starter/core/core.dart';
import 'package:starter/features/auth/domain/entities/entities.dart';
import 'package:starter/features/auth/domain/repositories/repositories.dart';

/// Use case for refreshing the session by fetching the latest profile from API.
///
/// This validates the stored session by making a network request.
/// If successful, the session is updated; otherwise, it's considered invalid.
class RefreshSessionUseCase implements UseCase<AuthSession, NoParams> {
  const RefreshSessionUseCase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Result<AuthSession>> call(NoParams params) async {
    return _repository.refreshSession();
  }
}
