import 'package:starter/core/core.dart';
import 'package:starter/features/onboarding/domain/domain.dart';
import 'package:starter/features/profile/domain/domain.dart';

/// Implementation of [IOnboardingRepository].
/// Delegates to profile repository to update user profile during onboarding.
class OnboardingRepositoryImpl implements IOnboardingRepository {
  const OnboardingRepositoryImpl(this._profileRepository);

  final IProfileRepository _profileRepository;

  @override
  Future<Result<UserProfile>> completeOnboarding({
    required String firstName,
    required String lastName,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) async {
    // Delegate to profile repository to update user data
    return _profileRepository.updateProfile(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
    );
  }
}
