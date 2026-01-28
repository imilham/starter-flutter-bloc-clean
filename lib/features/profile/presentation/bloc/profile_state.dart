part of 'profile_bloc.dart';

/// Base class for profile states.
sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action.
final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// Loading state during async operations.
final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// State when profile is successfully loaded.
final class ProfileLoaded extends ProfileState {
  const ProfileLoaded(this.profile);

  final UserProfile profile;

  @override
  List<Object?> get props => [profile];
}

/// State when profile is successfully updated.
final class ProfileUpdateSuccess extends ProfileState {
  const ProfileUpdateSuccess(this.profile);

  final UserProfile profile;

  @override
  List<Object?> get props => [profile];
}

/// State when profile is successfully deleted.
final class ProfileDeleted extends ProfileState {
  const ProfileDeleted();
}

/// Error state.
final class ProfileError extends ProfileState {
  const ProfileError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
