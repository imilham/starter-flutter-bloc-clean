part of 'onboarding_cubit.dart';

enum OnboardingStatus { initial, loading, success, failure }

class OnboardingState extends Equatable {
  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.errorMessage,
  });

  final OnboardingStatus status;
  final String? errorMessage;

  OnboardingState copyWith({
    OnboardingStatus? status,
    String? errorMessage,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
