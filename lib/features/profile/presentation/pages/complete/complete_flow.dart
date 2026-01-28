import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/features/profile/profile.dart';
import 'package:starter/utils/utils.dart';

class CompleteProfileFlow extends StatelessWidget {
  const CompleteProfileFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCompletionCubit(
        updateProfileUseCase: getIt<UpdateProfileUseCase>(),
      ),
      child: const _CompleteProfileFlowView(),
    );
  }
}

class _CompleteProfileFlowView extends StatelessWidget {
  const _CompleteProfileFlowView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCompletionCubit, ProfileCompletionState>(
      listener: (context, state) {
        if (state.status == ProfileCompletionStatus.failure && state.errorMessage != null) {
          CommonDialog.alert(
            context,
            title: context.l10n.error,
            message: state.errorMessage!,
          );
        } else if (state.status == ProfileCompletionStatus.success) {
           // Navigate away or show success message, typically handled by auth state change
           // but we can add specific logic here if needed.
        }
      },
      builder: (context, state) {
        final cubit = context.read<ProfileCompletionCubit>();
        final isLoading = state.status == ProfileCompletionStatus.loading;
        
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
                    // We can use a controller if we want animation, but for now simple switching
                    children: [
                      if (state.currentStep == 0) const StepOne(),
                      if (state.currentStep == 1) const Center(child: Text('Step 2 Placeholder')), // StepTwo(),
                      if (state.currentStep == 2) const Center(child: Text('Step 3 Placeholder')),
                    ],
                  ),
                ),
                Gap.medium16,
                CommonElevatedButton(
                  text: state.currentStep == 2 ? context.l10n.exploreApp : context.l10n.continueAction,
                  isLoading: isLoading,
                  onPressed: () {
                    if (state.currentStep == 0) {
                      cubit.submitStepOne();
                    } else if (state.currentStep == 1) {
                      cubit.submitStepTwo();
                    } else {
                      cubit.submitLastStep();
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
