import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

// TODO: remove-samples-im

class OverlaysSample extends StatelessWidget {
  const OverlaysSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedColumn(
      children: [
        const SectionHeader.large('Dialogs'),
        CommonElevatedButton(
          text: 'Show Alert Dialog',
          onPressed: () {
            CommonDialog.alert(
              context,
              title: 'This is an Alert',
              message: 'Here is some important information for the user.',
            );
          },
        ),
        Gap.medium16,
        CommonElevatedButton(
          text: 'Show Confirm Dialog',
          onPressed: () {
            CommonDialog.confirm(
              context,
              title: 'Are you sure?',
              message: 'This action cannot be undone.',
              isDangerous: true,
            );
          },
        ),
        Gap.large24,
        const SectionHeader.large('Bottom Sheet'),
        CommonElevatedButton(
          text: 'Show Bottom Sheet',
          onPressed: () {
            CommonBottomSheet.show<void>(
              context,
              title: 'My Bottom Sheet',
              child: Container(
                height: 200,
                alignment: Alignment.center,
                child: Text('Sheet Content Goes Here', style: bodyRegular()),
              ),
            );
          },
        ),
        Gap.large24,
        const SectionHeader.large('Snackbars'),
        CommonElevatedButton(
          text: 'Show Success Snackbar',
          onPressed: () {
            context.showSuccessSnackBar('Operation completed successfully!');
          },
        ),
        Gap.medium16,
        CommonElevatedButton(
          text: 'Show Error Snackbar',
          onPressed: () {
            context.showErrorSnackBar('Something went wrong!');
          },
        ),
        Gap.medium16,
        CommonElevatedButton(
          text: 'Show Custom Snackbar',
          onPressed: () {
            context.showCustomSnackBar(
              content: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  Gap.small8,
                  Expanded(
                    child: Text(
                      'You earned 50 points!',
                      style: bodySmall(textColor: Colors.white),
                    ),
                  ),
                  Gap.small8,
                  const Icon(Icons.celebration, color: Colors.pinkAccent),
                ],
              ),
              backgroundColor: Colors.indigo,
            );
          },
        ),
      ],
    );
  }
}
