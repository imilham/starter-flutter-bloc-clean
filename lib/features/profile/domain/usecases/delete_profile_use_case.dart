import 'package:starter/core/core.dart';
import 'package:starter/features/profile/domain/domain.dart';

/// Use case for deleting user account.
class DeleteProfileUseCase implements UseCase<void, NoParams> {
  const DeleteProfileUseCase(this._repository);

  final IProfileRepository _repository;

  @override
  Future<Result<void>> call(NoParams params) async {
    return _repository.deleteProfile();
  }
}
