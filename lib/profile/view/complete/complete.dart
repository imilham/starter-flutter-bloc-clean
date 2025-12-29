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
      await showAdaptiveDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text('Error'),
            content: Text(state.message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
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
        return AbsorbPointer(
          absorbing: snapshot.data is ProfileLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Sign Up'),
              automaticallyImplyLeading: false,
              leading: controller.currentStep > 0
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: controller.previousStep,
                    )
                  : null,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: LinearProgressIndicator(
                    value: controller.progress,
                    borderRadius: BorderRadius.circular(8),
                    minHeight: 5,
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.red,
                        child: const Center(child: Text('Step 1')),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.green,
                        child: const Center(child: Text('Step 2')),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.blue,
                        child: const Center(child: Text('Step 3')),
                      ),
                    ],
                  ),
                ),
                const FixedGap(mainAxisExtent: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.currentStep == 0) {
                        controller.onSubmitFirstStep();
                      } else if (controller.currentStep == 1) {
                        controller.onSubmitSecondStep();
                      } else {
                        controller.onSubmitLastStep();
                      }
                    },
                    child: Builder(
                      builder: (context) {
                        if (snapshot.data is ProfileLoading) {
                          return SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.6),
                              ),
                            ),
                          );
                        }
                        return Text(controller.currentStep == 2 ? 'Explore The App' : 'Continue');
                      },
                    ),
                  ),
                ),
                const RelativeGap(mainAxisExtent: 0.05),
              ],
            ),
          ),
        );
      },
    );
  }
}
