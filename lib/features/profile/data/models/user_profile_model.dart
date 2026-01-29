import 'package:starter/features/profile/domain/entities/entities.dart';

/// Data model for UserProfile with JSON serialization.
class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.uuid,
    required super.firstName,
    required super.lastName,
    super.phoneNumber,
    super.dateOfBirth,
    super.isEmailVerified,
    super.isProfileCompleted,
  });

  /// Creates a model from JSON map.
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      uuid: json['uuid'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      phoneNumber: json['phone_number'] as String?,
      dateOfBirth: json['date_of_birth'] != null ? DateTime.tryParse(json['date_of_birth'] as String) : null,
      isEmailVerified: (json['is_email_verified'] ?? false) as bool,
      isProfileCompleted: (json['is_profile_completed'] ?? false) as bool,
    );
  }

  /// Creates a model from entity.
  factory UserProfileModel.fromEntity(UserProfile entity) {
    return UserProfileModel(
      uuid: entity.uuid,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNumber: entity.phoneNumber,
      dateOfBirth: entity.dateOfBirth,
      isEmailVerified: entity.isEmailVerified,
      isProfileCompleted: entity.isProfileCompleted,
    );
  }

  /// Converts model to JSON map.
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'firstName': firstName,
      'lastName': lastName,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth!.toIso8601String(),
      'is_email_verified': isEmailVerified,
      'is_profile_completed': isProfileCompleted,
    };
  }
}
