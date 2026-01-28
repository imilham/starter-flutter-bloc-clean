part of 'sign_up_cubit.dart';

/// States for the sign up form.
sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

/// Initial state of the sign up form.
final class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

/// Sign up is in progress.
final class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

/// Sign up was successful.
final class SignUpSuccess extends SignUpState {
  const SignUpSuccess(this.session);

  final AuthSession session;

  @override
  List<Object?> get props => [session];
}

/// Sign up failed.
final class SignUpFailure extends SignUpState {
  const SignUpFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
