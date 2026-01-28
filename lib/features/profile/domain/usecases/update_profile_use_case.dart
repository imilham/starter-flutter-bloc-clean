import 'package:starter/core/core.dart';
import 'package:starter/features/profile/domain/domain.dart';

/// Use case for updating user profile.
class UpdateProfileUseCase implements UseCase<UserProfile, UpdateProfileParams> {
  const UpdateProfileUseCase(this._repository);

  final IProfileRepository _repository;

  @override
  Future<Result<UserProfile>> call(UpdateProfileParams params) async {
    return _repository.updateProfile(
      firstName: params.firstName,
      lastName: params.lastName,
    );
  }
}

/// Parameters for [UpdateProfileUseCase].
class UpdateProfileParams {
  const UpdateProfileParams({
    required this.firstName,
    required this.lastName,
  });

  final String firstName;
  final String lastName;
}
