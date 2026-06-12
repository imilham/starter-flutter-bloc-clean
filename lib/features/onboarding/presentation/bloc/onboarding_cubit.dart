import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/features/onboarding/domain/domain.dart';

part 'onboarding_state.dart';

/// Cubit for managing the onboarding flow.
///
/// Holds form controllers and drives the [CompleteOnboardingUseCase].
/// The repository implementation is the only thing a developer needs
/// to wire when the real API is ready.
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required CompleteOnboardingUseCase completeOnboardingUseCase,
  })  : _completeOnboardingUseCase = completeOnboardingUseCase,
        super(const OnboardingState());

  final CompleteOnboardingUseCase _completeOnboardingUseCase;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// Validates the form and calls [CompleteOnboardingUseCase].
  ///
  /// On success, triggers [AuthCheckRequested] which causes the router
  /// to redirect away from the onboarding route automatically.
  Future<void> submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    emit(state.copyWith(status: OnboardingStatus.loading));

    final result = await _completeOnboardingUseCase(
      CompleteOnboardingParams(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
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
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    return super.close();
  }
}
