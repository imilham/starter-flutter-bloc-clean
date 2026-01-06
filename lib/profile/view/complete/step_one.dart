import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedColumn(
      padding: AppSpacing.allMd,
      children: [
        const CommonText('Step 1: Personal Details').size18px.bold,
        Gap.medium16,
        Center(child: const CommonText('Form content goes here').size14px),
      ],
    );
  }
}
