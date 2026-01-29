import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/features/onboarding/domain/domain.dart';
import 'package:starter/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:starter/features/onboarding/presentation/pages/step_one.dart';
import 'package:starter/features/onboarding/presentation/pages/step_two.dart';
import 'package:starter/utils/utils.dart';

class OnboardingFlow extends StatelessWidget {
  const OnboardingFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(
        completeOnboardingUseCase: getIt<CompleteOnboardingUseCase>(),
      ),
      child: const _OnboardingFlowView(),
    );
  }
}

class _OnboardingFlowView extends StatelessWidget {
  const _OnboardingFlowView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state.status == OnboardingStatus.failure && state.errorMessage != null) {
          CommonDialog.alert(
            context,
            title: context.l10n.error,
            message: state.errorMessage!,
          );
        } else if (state.status == OnboardingStatus.success) {
          // Navigate away or show success message, typically handled by auth state change
          // but we can add specific logic here if needed.
        }
      },
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        final isLoading = state.status == OnboardingStatus.loading;

        return AbsorbPointer(
          absorbing: isLoading,
          child: Scaffold(
            appBar: CommonAppBar(
              title: context.l10n.introSignUp,
              showBackButton: state.currentStep > 0,
              onBackPress: cubit.previousStep,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: LinearProgressIndicator(
                    value: state.progress,
                    borderRadius: AppRadius.small8,
                    minHeight: 5,
                  ),
                ),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      if (state.currentStep == 0) const StepOne(),
                      if (state.currentStep == 1) const StepTwo(),
                    ],
                  ),
                ),
                Gap.medium16,
                CommonElevatedButton(
                  text: state.currentStep == 1 ? context.l10n.completeProfile : context.l10n.continueAction,
                  isLoading: isLoading,
                  onPressed: () {
                    if (state.currentStep == 0) {
                      cubit.submitStepOne();
                    } else {
                      cubit.submitStepTwo();
                    }
                  },
                ).paddingHorizontal16,
                const RelativeGap(mainAxisExtent: 0.05),
              ],
            ),
          ),
        );
      },
    );
  }
}
