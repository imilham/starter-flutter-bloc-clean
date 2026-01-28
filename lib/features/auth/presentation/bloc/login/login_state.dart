part of 'login_cubit.dart';

/// States for the login form.
sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

/// Initial state of the login form.
final class LoginInitial extends LoginState {
  const LoginInitial();
}

/// Login is in progress.
final class LoginLoading extends LoginState {
  const LoginLoading();
}

/// Login was successful.
final class LoginSuccess extends LoginState {
  const LoginSuccess(this.session);

  final AuthSession session;

  @override
  List<Object?> get props => [session];
}

/// Login failed.
final class LoginFailure extends LoginState {
  const LoginFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
