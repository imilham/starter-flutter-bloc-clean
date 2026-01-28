import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:starter/features/profile/profile.dart';
import 'package:starter/utils/utils.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCompletionCubit>();

    return Form(
      key: cubit.stepOneFormKey,
      child: ExtendedColumn(
        children: [
          Text(
            context.l10n.step1Title,
            style: headline20(fontWeight: FontWeight.bold),
          ),
          Gap.medium16,
          CommonBaseTextField(
            controller: cubit.firstNameController,
            hintText: context.l10n.firstName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.l10n.firstNameRequired;
              }
              return null;
            },
          ),
          Gap.small8,
          CommonBaseTextField(
            controller: cubit.lastNameController,
            hintText: context.l10n.lastName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.l10n.lastNameRequired;
              }
              return null;
            },
          ),
          Gap.medium16,
          Center(
            child: Text(
              context.l10n.formContent,
              style: bodyRegular16(),
            ),
          ),
          const Spacer(),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: context.l10n.agreeTo,
                  style: bodyXSmall12(),
                ),
                TextSpan(
                  text: context.l10n.termsOfService,
                  style: bodyXSmall12(
                    fontWeight: FontWeight.bold,
                    textColor: context.colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(
                  text: context.l10n.and,
                  style: bodyXSmall12(),
                ),
                TextSpan(
                  text: context.l10n.privacyPolicy,
                  style: bodyXSmall12(
                    fontWeight: FontWeight.bold,
                    textColor: context.colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ],
      ).paddingAll16,
    );
  }
}
