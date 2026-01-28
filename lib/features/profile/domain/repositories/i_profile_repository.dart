import 'package:starter/core/core.dart';
import 'package:starter/features/profile/domain/entities/entities.dart';

/// Repository interface for profile operations.
abstract interface class IProfileRepository {
  /// Gets the current user profile.
  Future<Result<UserProfile>> getProfile();

  /// Updates the user profile.
  Future<Result<UserProfile>> updateProfile({
    required String firstName,
    required String lastName,
  });

  /// Deletes the user account.
  Future<Result<void>> deleteProfile();
}
