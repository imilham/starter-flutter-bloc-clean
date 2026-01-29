import 'package:starter/core/core.dart';
import 'package:starter/features/profile/domain/entities/entities.dart';

/// Repository interface for onboarding operations.
abstract interface class IOnboardingRepository {
  /// Completes the onboarding process by updating user profile.
  /// Returns the updated UserProfile with profile marked as completed.
  Future<Result<UserProfile>> completeOnboarding({
    required String firstName,
    required String lastName,
    String? phoneNumber,
    DateTime? dateOfBirth,
  });
}
