import 'package:flutter/material.dart';
import 'package:starter/features/more/presentation/pages/samples/sample_section.dart';
import 'package:starter/utils/utils.dart';

// TODO: remove-samples-im

class OverlaysSample extends StatelessWidget {
  const OverlaysSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'System Overlays',
          style: context.textTheme.headlineMedium,
        ),
        Gap.small8,
        Text(
          'Dialogs, sheets, and notifications.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Gap.medium16,
        SampleSection(
          title: 'Dialogs',
          icon: Icons.window,
          isExpanded: true,
          children: [
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
          ],
        ),
        SampleSection(
          title: 'Bottom Sheet',
          icon: Icons.layers,
          children: [
            CommonElevatedButton(
              text: 'Show Bottom Sheet',
              onPressed: () {
                CommonBottomSheet.show<void>(
                  context,
                  title: 'My Bottom Sheet',
                  child: Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: Text('Sheet Content Goes Here', style: bodyRegular16()),
                  ),
                );
              },
            ),
          ],
        ),
        SampleSection(
          title: 'Snackbars',
          icon: Icons.message,
          children: [
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
                          style: bodySmall14(textColor: Colors.white),
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
        ),
        SampleSection(
          title: 'Toasts',
          icon: Icons.notifications_active,
          children: [
            CommonElevatedButton(
              text: 'Show Toast (Bottom)',
              onPressed: () {
                context.showToast('This is a toast message');
              },
            ),
            Gap.medium16,
            CommonElevatedButton(
              text: 'Show Toast (Top)',
              onPressed: () {
                context.showToast('Top Toast', gravity: ToastGravity.top);
              },
            ),
            Gap.medium16,
            CommonElevatedButton(
              text: 'Show Success Toast',
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              onPressed: () {
                context.showToast(
                  'Operation successful!',
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                );
              },
            ),
            Gap.medium16,
            CommonElevatedButton(
              text: 'Show Long Toast (3.5s)',
              onPressed: () {
                context.showToast('Long Toast Message', length: ToastLength.long);
              },
            ),
          ],
        ),
      ],
    );
  }
}
