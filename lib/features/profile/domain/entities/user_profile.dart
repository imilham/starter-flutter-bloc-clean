import 'package:equatable/equatable.dart';

/// User profile entity - pure domain object.
class UserProfile extends Equatable {
  const UserProfile({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
    this.isEmailVerified = false,
    this.isProfileCompleted = false,
  });

  final String uuid;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final bool isEmailVerified;
  final bool isProfileCompleted;

  /// Returns full name of the user.
  String get fullName => '$firstName $lastName'.trim();

  /// Creates a copy of this profile with optional parameter overrides.
  UserProfile copyWith({
    String? uuid,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    DateTime? dateOfBirth,
    bool? isEmailVerified,
    bool? isProfileCompleted,
  }) {
    return UserProfile(
      uuid: uuid ?? this.uuid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
    );
  }

  @override
  List<Object?> get props => [
        uuid,
        firstName,
        lastName,
        phoneNumber,
        dateOfBirth,
        isEmailVerified,
        isProfileCompleted,
      ];
}
