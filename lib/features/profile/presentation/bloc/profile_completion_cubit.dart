import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/features/profile/domain/domain.dart';

part 'profile_completion_state.dart';

/// Cubit for managing profile completion flow.
class ProfileCompletionCubit extends Cubit<ProfileCompletionState> {
  ProfileCompletionCubit({
    required UpdateProfileUseCase updateProfileUseCase,
  })  : _updateProfileUseCase = updateProfileUseCase,
        super(const ProfileCompletionState());

  final UpdateProfileUseCase _updateProfileUseCase;
  static const int stepCount = 3;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final stepOneFormKey = GlobalKey<FormState>();
  final stepTwoFormKey = GlobalKey<FormState>();

  void nextStep() {
    if (state.currentStep < stepCount - 1) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  Future<void> submitStepOne() async {
    if (stepOneFormKey.currentState?.validate() ?? false) {
      nextStep();
    } else {
      emit(state.copyWith(status: ProfileCompletionStatus.failure, errorMessage: 'Please fill in all fields'));
      // Reset status after error to allow new events
      emit(state.copyWith(status: ProfileCompletionStatus.initial));
    }
  }

  Future<void> submitStepTwo() async {
    if (stepTwoFormKey.currentState?.validate() ?? false) {
       nextStep();
    } else {
      emit(state.copyWith(status: ProfileCompletionStatus.failure, errorMessage: 'Please fill in all fields'));
      emit(state.copyWith(status: ProfileCompletionStatus.initial));
    }
  }

  Future<void> submitLastStep() async {
    emit(state.copyWith(status: ProfileCompletionStatus.loading));
    
    final result = await _updateProfileUseCase(
      UpdateProfileParams(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
      ),
    );

    result.fold(
      onSuccess: (_) {
        getIt<AuthBloc>().add(const AuthCheckRequested());
        emit(state.copyWith(status: ProfileCompletionStatus.success));
      },
      onFailure: (failure) {
        emit(state.copyWith(
          status: ProfileCompletionStatus.failure, 
          errorMessage: failure.message,
        ),);
      },
    );
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    return super.close();
  }
}
