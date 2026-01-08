import 'dart:async';

import 'package:flutter/material.dart';
import 'package:starter/profile/profile.dart';
import 'package:starter/utils/utils.dart';

class CompleteProfileFlow extends StatefulWidget {
  const CompleteProfileFlow({super.key});

  @override
  State<CompleteProfileFlow> createState() => _CompleteProfileFlowState();
}

class _CompleteProfileFlowState extends State<CompleteProfileFlow> {
  late ProfileCompleteController _profileCompleteController;
  late StreamSubscription<ProfileState> _subscription;

  @override
  void initState() {
    _profileCompleteController = context.read<ProfileCompleteController>();
    _subscription = _profileCompleteController.state.listen(onAuthStateChanged);
    super.initState();
  }

  Future<void> onAuthStateChanged(ProfileState state) async {
    if (state is ProfileUpdateFailed && mounted) {
      await CommonDialog.alert(
        context,
        title: 'Error',
        message: state.message,
      );
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileCompleteController>();
    return StreamBuilder<ProfileState>(
      stream: controller.state,
      builder: (context, snapshot) {
        final isLoading = snapshot.data is ProfileLoading;
        return AbsorbPointer(
          absorbing: isLoading,
          child: Scaffold(
            appBar: CommonAppBar(
              title: 'Sign Up',
              showBackButton: controller.currentStep > 0,
              onBackPress: controller.previousStep,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: LinearProgressIndicator(
                    value: controller.progress,
                    borderRadius: AppRadius.small8,
                    minHeight: 5,
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      StepOne(),
                      // TODO(ilham): Add StepTwo() widget here
                    ],
                  ),
                ),
                Gap.medium16,
                CommonElevatedButton(
                  text: controller.currentStep == 2 ? 'Explore The App' : 'Continue',
                  isLoading: isLoading,
                  onPressed: () {
                    if (controller.currentStep == 0) {
                      controller.onSubmitFirstStep();
                    } else if (controller.currentStep == 1) {
                      controller.onSubmitSecondStep();
                    } else {
                      controller.onSubmitLastStep();
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
