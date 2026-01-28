import 'package:starter/core/core.dart';
import 'package:starter/features/profile/domain/domain.dart';

/// Use case for getting the user profile.
class GetProfileUseCase implements UseCase<UserProfile, NoParams> {
  const GetProfileUseCase(this._repository);

  final IProfileRepository _repository;

  @override
  Future<Result<UserProfile>> call(NoParams params) async {
    return _repository.getProfile();
  }
}
