import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedColumn(
      children: [
        Text(
          context.l10n.step1Title,
          style: headline20(fontWeight: FontWeight.bold),
        ),
        Gap.medium16,
        Center(
          child: Text(
            context.l10n.formContent,
            style: bodyRegular16(),
          ),
        ),
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
    ).paddingAll16;
  }
}
