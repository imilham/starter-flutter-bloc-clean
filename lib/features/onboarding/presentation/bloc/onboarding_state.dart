part of 'onboarding_cubit.dart';

enum OnboardingStatus { initial, loading, success, failure }

class OnboardingState extends Equatable {
  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.currentStep = 0,
    this.errorMessage,
  });

  final OnboardingStatus status;
  final int currentStep;
  final String? errorMessage;

  double get progress => (currentStep + 1) / OnboardingCubit.stepCount;

  OnboardingState copyWith({
    OnboardingStatus? status,
    int? currentStep,
    String? errorMessage,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, currentStep, errorMessage];
}
