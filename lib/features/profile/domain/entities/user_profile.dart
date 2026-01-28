import 'package:equatable/equatable.dart';

/// User profile entity - pure domain object.
class UserProfile extends Equatable {
  const UserProfile({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    this.isEmailVerified = false,
    this.isProfileCompleted = false,
  });

  final String uuid;
  final String firstName;
  final String lastName;
  final bool isEmailVerified;
  final bool isProfileCompleted;

  /// Returns full name of the user.
  String get fullName => '$firstName $lastName'.trim();

  /// Creates a copy of this profile with optional parameter overrides.
  UserProfile copyWith({
    String? uuid,
    String? firstName,
    String? lastName,
    bool? isEmailVerified,
    bool? isProfileCompleted,
  }) {
    return UserProfile(
      uuid: uuid ?? this.uuid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
    );
  }

  @override
  List<Object?> get props => [
        uuid,
        firstName,
        lastName,
        isEmailVerified,
        isProfileCompleted,
      ];
}
