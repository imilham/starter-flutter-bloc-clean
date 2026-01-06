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
          style: headline3(fontWeight: FontWeight.bold),
        ),
        Gap.medium16,
        Center(
          child: Text(
            'Form content goes here',
            style: bodyRegular(),
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'By continuing, you agree to our ',
                style: bodyXSmall(),
              ),
              TextSpan(
                text: 'Terms of Service',
                style: bodyXSmall(
                  fontWeight: FontWeight.bold,
                  textColor: context.colorScheme.primary,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
              TextSpan(
                text: ' and ',
                style: bodyXSmall(),
              ),
              TextSpan(
                text: 'Privacy Policy',
                style: bodyXSmall(
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
