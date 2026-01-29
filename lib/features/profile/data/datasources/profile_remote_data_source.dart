import 'package:starter/features/profile/data/models/models.dart';

/// Remote data source for profile operations.
abstract interface class ProfileRemoteDataSource {
  /// Gets the user profile from API.
  Future<UserProfileModel> getProfile();

  /// Updates the user profile via API.
  Future<UserProfileModel> updateProfile({
    required String firstName,
    required String lastName,
    String? phoneNumber,
    DateTime? dateOfBirth,
  });

  /// Deletes the user account via API.
  Future<void> deleteProfile();
}
