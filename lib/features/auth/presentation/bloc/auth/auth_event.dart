part of 'auth_bloc.dart';

/// Events for the global auth state.
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Check if user has a stored session.
final class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// Notifies that a session was established (after successful login/signup/verification).
final class AuthSessionEstablished extends AuthEvent {
  const AuthSessionEstablished(this.session);

  final AuthSession session;

  @override
  List<Object?> get props => [session];
}

/// User logged out.
final class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
