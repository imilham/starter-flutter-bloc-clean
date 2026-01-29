import 'package:starter/core/core.dart';
import 'package:starter/features/onboarding/domain/domain.dart';
import 'package:starter/features/profile/domain/entities/entities.dart';

/// Use case for completing the onboarding process.
class CompleteOnboardingUseCase implements UseCase<UserProfile, CompleteOnboardingParams> {
  const CompleteOnboardingUseCase(this._repository);

  final IOnboardingRepository _repository;

  @override
  Future<Result<UserProfile>> call(CompleteOnboardingParams params) async {
    return _repository.completeOnboarding(
      firstName: params.firstName,
      lastName: params.lastName,
      phoneNumber: params.phoneNumber,
      dateOfBirth: params.dateOfBirth,
    );
  }
}

/// Parameters for [CompleteOnboardingUseCase].
class CompleteOnboardingParams {
  const CompleteOnboardingParams({
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
  });

  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
}
