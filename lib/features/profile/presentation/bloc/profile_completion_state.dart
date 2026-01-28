part of 'profile_completion_cubit.dart';

enum ProfileCompletionStatus { initial, loading, success, failure }

class ProfileCompletionState extends Equatable {
  const ProfileCompletionState({
    this.status = ProfileCompletionStatus.initial,
    this.currentStep = 0,
    this.errorMessage,
  });

  final ProfileCompletionStatus status;
  final int currentStep;
  final String? errorMessage;

  double get progress => (currentStep + 1) / ProfileCompletionCubit.stepCount;

  ProfileCompletionState copyWith({
    ProfileCompletionStatus? status,
    int? currentStep,
    String? errorMessage,
  }) {
    return ProfileCompletionState(
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, currentStep, errorMessage];
}
