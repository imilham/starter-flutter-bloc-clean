import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExtendedColumn(
      padding: AppSpacing.allMd,
      children: [
        Text('Step 1: Personal Details'),
        Gap.medium16,
        Center(child: Text('Form content goes here')),
      ],
    );
  }
}
