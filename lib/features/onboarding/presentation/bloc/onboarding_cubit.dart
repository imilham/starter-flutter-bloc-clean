import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/features/onboarding/domain/domain.dart';

part 'onboarding_state.dart';

/// Cubit for managing onboarding flow.
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required CompleteOnboardingUseCase completeOnboardingUseCase,
  })  : _completeOnboardingUseCase = completeOnboardingUseCase,
        super(const OnboardingState());

  final CompleteOnboardingUseCase _completeOnboardingUseCase;
  static const int stepCount = 2;

  // Step 1 controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final stepOneFormKey = GlobalKey<FormState>();
  
  // Step 2 controllers
  final phoneNumberController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final stepTwoFormKey = GlobalKey<FormState>();
  
  DateTime? _selectedDateOfBirth;

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

  void setDateOfBirth(DateTime date) {
    _selectedDateOfBirth = date;
    dateOfBirthController.text = DateFormat('MMM dd, yyyy').format(date);
  }

  Future<void> submitStepOne() async {
    if (stepOneFormKey.currentState?.validate() ?? false) {
      nextStep();
    } else {
      emit(state.copyWith(status: OnboardingStatus.failure, errorMessage: 'Please fill in all fields'));
      // Reset status after error to allow new events
      emit(state.copyWith(status: OnboardingStatus.initial));
    }
  }

  Future<void> submitStepTwo() async {
    if (stepTwoFormKey.currentState?.validate() ?? false) {
      emit(state.copyWith(status: OnboardingStatus.loading));

      final result = await _completeOnboardingUseCase(
        CompleteOnboardingParams(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phoneNumber: phoneNumberController.text.isEmpty ? null : phoneNumberController.text,
          dateOfBirth: _selectedDateOfBirth,
        ),
      );

      result.fold(
        onSuccess: (_) {
          getIt<AuthBloc>().add(const AuthCheckRequested());
          emit(state.copyWith(status: OnboardingStatus.success));
        },
        onFailure: (failure) {
          emit(
            state.copyWith(
              status: OnboardingStatus.failure,
              errorMessage: failure.message,
            ),
          );
        },
      );
    } else {
      emit(state.copyWith(status: OnboardingStatus.failure, errorMessage: 'Please fill in all required fields'));
      emit(state.copyWith(status: OnboardingStatus.initial));
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    dateOfBirthController.dispose();
    return super.close();
  }
}
