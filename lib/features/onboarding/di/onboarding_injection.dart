import 'package:get_it/get_it.dart';
import 'package:starter/features/onboarding/onboarding.dart';
import 'package:starter/features/profile/profile.dart';

/// Extension on GetIt to register onboarding feature dependencies.
///
/// Registers repository and use case for the onboarding feature.
extension OnboardingInjection on GetIt {
  /// Registers all onboarding feature dependencies.
  void registerOnboardingFeature() {
    // Repository - depends on profile repository
    registerLazySingleton<IOnboardingRepository>(
      () => OnboardingRepositoryImpl(get<IProfileRepository>()),
    );

    // Use Case
    registerFactory<CompleteOnboardingUseCase>(
      () => CompleteOnboardingUseCase(get<IOnboardingRepository>()),
    );
  }
}
