part of 'profile_bloc.dart';

/// Base class for profile events.
sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load user profile.
final class ProfileLoadRequested extends ProfileEvent {
  const ProfileLoadRequested();
}

/// Event to update user profile.
final class ProfileUpdateRequested extends ProfileEvent {
  const ProfileUpdateRequested({
    required this.firstName,
    required this.lastName,
  });

  final String firstName;
  final String lastName;

  @override
  List<Object?> get props => [firstName, lastName];
}

/// Event to delete user account.
final class ProfileDeleteRequested extends ProfileEvent {
  const ProfileDeleteRequested();
}
