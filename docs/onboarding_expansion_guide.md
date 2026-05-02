# Developer Guide: Expanding the Onboarding Flow

This guide provides a detailed technical walkthrough for adding new steps to the multi-stage onboarding process in the `starter-im` project.

## Overview of the Onboarding Architecture

The onboarding flow uses a **Page-Based State Machine** pattern:
1.  **Cubit (`OnboardingCubit`)**: Manages the current step index, field validation, and final API submission.
2.  **Flow View (`_OnboardingFlowView`)**: Uses a `PageView` and a `LinearProgressIndicator` to display steps based on the index.
3.  **Use Cases**: Handles the final data submission to the domain/data layer.

---

## Step-by-Step Expansion Instructions

### 1. Update the Domain Layer
If your new step collects data (e.g., "Company Name"), you must register this field in the logic definition.

**File:** [complete_onboarding_use_case.dart](file:///Users/developer/Documents/Ilham/starter-im/lib/features/onboarding/domain/usecases/complete_onboarding_use_case.dart)

```dart
// 1. Add to the parameter class
class CompleteOnboardingParams {
  const CompleteOnboardingParams({
    // ... existing fields
    this.companyName, // NEW FIELD
  });

  final String? companyName;
}

// 2. Update the UseCase call
@override
Future<Result<UserProfile>> call(CompleteOnboardingParams params) async {
  return _repository.completeOnboarding(
    // ...
    companyName: params.companyName,
  );
}
```

---

### 2. Update the State & Navigation (Cubit)
The Cubit is the "brain" of the flow.

**File:** [onboarding_cubit.dart](file:///Users/developer/Documents/Ilham/starter-im/lib/features/onboarding/presentation/bloc/onboarding_cubit.dart)

1.  **Update Step Count:**
    ```dart
    static const int stepCount = 3; // Change from 2 to 3
    ```

2.  **Add New Form Controllers:**
    ```dart
    // Step 3 controllers
    final companyNameController = TextEditingController();
    final stepThreeFormKey = GlobalKey<FormState>();
    ```

3.  **Update Submission Chain:**
    *   Change `submitStepTwo` to simply validate and call `nextStep()`.
    *   Add `submitStepThree` to perform the actual API call.

```dart
Future<void> submitStepTwo() async {
    if (stepTwoFormKey.currentState?.validate() ?? false) {
      nextStep(); // Goes to step 3 instead of submitting
    }
}

Future<void> submitStepThree() async {
    if (stepThreeFormKey.currentState?.validate() ?? false) {
      emit(state.copyWith(status: OnboardingStatus.loading));
      // Call UseCase here with ALL data from all 3 steps
    }
}
```

---

### 3. Create the UI Widget
Create a new file `lib/features/onboarding/presentation/pages/step_three.dart`.

```dart
class StepThree extends StatelessWidget {
  const StepThree({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    return Form(
      key: cubit.stepThreeFormKey,
      child: Column(
        children: [
          CommonBaseTextField(
            controller: cubit.companyNameController,
            title: 'Company Name',
          ),
        ],
      ),
    );
  }
}
```

---

### 4. Wire the Step into the Flow
Finally, tell the UI to render the new step.

**File:** [onboarding_flow.dart](file:///Users/developer/Documents/Ilham/starter-im/lib/features/onboarding/presentation/pages/onboarding_flow.dart)

1.  **Update the Navigation Button:**
    ```dart
    CommonButton.primary(
      // The button text should show "Complete" only on the LAST step (index 2)
      text: state.currentStep == 2 
          ? context.l10n.completeProfile 
          : context.l10n.continueAction,
      onPressed: () {
        if (state.currentStep == 0) cubit.submitStepOne();
        else if (state.currentStep == 1) cubit.submitStepTwo();
        else cubit.submitStepThree(); // Final submission
      },
    )
    ```

2.  **Update the PageView Content:**
    ```dart
    PageView(
      children: [
        if (state.currentStep == 0) const StepOne(),
        if (state.currentStep == 1) const StepTwo(),
        if (state.currentStep == 2) const StepThree(),
      ],
    )
    ```

---

## Technical References
*   **State Management**: [OnboardingCubit](file:///Users/developer/Documents/Ilham/starter-im/lib/features/onboarding/presentation/bloc/onboarding_cubit.dart)
*   **Logic Definition**: [CompleteOnboardingUseCase](file:///Users/developer/Documents/Ilham/starter-im/lib/features/onboarding/domain/usecases/complete_onboarding_use_case.dart)
*   **UI Container**: [OnboardingFlow](file:///Users/developer/Documents/Ilham/starter-im/lib/features/onboarding/presentation/pages/onboarding_flow.dart)
