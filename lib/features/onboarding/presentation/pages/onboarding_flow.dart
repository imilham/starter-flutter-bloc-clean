import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/features/onboarding/domain/domain.dart';
import 'package:starter/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:starter/features/onboarding/presentation/pages/step_one.dart';
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
              showBackButton: false,
            ),
            body: Column(
              children: [
                const Expanded(child: StepOne()),
                Gap.medium16,
                CommonButton.primary(
                  label: context.l10n.completeProfile,
                  isLoading: isLoading,
                  onPressed: cubit.submit,
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

