import 'package:flutter/material.dart';
import 'package:starter/features/onboarding/onboarding.dart';
import 'package:starter/utils/utils.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Form(
      key: cubit.stepTwoFormKey,
      child: ExtendedColumn(
        children: [
          Text(
            context.l10n.step2Title,
            style: headline20(fontWeight: FontWeight.bold),
          ),
          Gap.medium16,
          CommonBaseTextField(
            controller: cubit.phoneNumberController,
            hintText: context.l10n.phoneNumberOptional,
            keyboardType: TextInputType.phone,
            validator: (value) {
              // Phone is optional, so only validate if provided
              if (value != null && value.isNotEmpty) {
                if (value.length < 10) {
                  return 'Please enter a valid phone number';
                }
              }
              return null;
            },
          ),
          Gap.small8,
          GestureDetector(
            onTap: () => _selectDate(context, cubit),
            child: AbsorbPointer(
              child: CommonBaseTextField(
                controller: cubit.dateOfBirthController,
                hintText: context.l10n.dateOfBirth,
                suffixIcon: const Icon(Icons.calendar_today),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your date of birth';
                  }
                  return null;
                },
              ),
            ),
          ),
          Gap.medium16,
          Center(
            child: Text(
              'Complete your profile to continue',
              style: bodyRegular16(),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
        ],
      ).paddingAll16,
    );
  }

  Future<void> _selectDate(BuildContext context, OnboardingCubit cubit) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)), // 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select your date of birth',
    );

    if (picked != null) {
      cubit.setDateOfBirth(picked);
    }
  }
}
