import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedColumn(
      padding: AppSpacing.allMd,
      children: [
        Text(
          'Step 1: Personal Details',
          style: headline20(fontWeight: FontWeight.bold),
        ),
        Gap.medium16,
        Center(
          child: Text(
            'Form content goes here',
            style: bodyRegular16(),
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'By continuing, you agree to our ',
                style: bodyXSmall12(),
              ),
              TextSpan(
                text: 'Terms of Service',
                style: bodyXSmall12(
                  fontWeight: FontWeight.bold,
                  textColor: context.colorScheme.primary,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
              TextSpan(
                text: ' and ',
                style: bodyXSmall12(),
              ),
              TextSpan(
                text: 'Privacy Policy',
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
    );
  }
}
