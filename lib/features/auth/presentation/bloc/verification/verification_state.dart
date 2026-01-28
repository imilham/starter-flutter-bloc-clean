import 'package:equatable/equatable.dart';
import 'package:starter/features/auth/auth.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object?> get props => [];
}

class VerificationInitial extends VerificationState {
  const VerificationInitial();
}

class VerificationLoading extends VerificationState {
  const VerificationLoading();
}

class VerificationSuccess extends VerificationState {
  const VerificationSuccess(this.session);
  final AuthSession session;

  @override
  List<Object?> get props => [session];
}

class VerificationFailure extends VerificationState {
  const VerificationFailure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
