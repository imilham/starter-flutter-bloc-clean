import 'package:flutter/material.dart';
import 'package:starter/features/dev/presentation/pages/sample_section.dart';
import 'package:starter/utils/utils.dart';

// TODO(developer): remove-samples-im

class OverlaysSample extends StatelessWidget {
  const OverlaysSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'System Overlays',
          style: context.headline20(),
        ),
        Gap.small8,
        Text(
          'Dialogs, sheets, and notifications.',
          style: context.bodyMedium14(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Gap.medium16,
        SampleSection(
          title: 'Dialogs',
          icon: Icons.window,
          isExpanded: true,
          children: [
            CommonButton.primary(
              label: 'Show Alert Dialog',
              onPressed: () {
                CommonDialog.alert(
                  context,
                  title: 'This is an Alert',
                  message: 'Here is some important information for the user.',
                );
              },
            ),
            Gap.medium16,
            CommonButton.primary(
              label: 'Show Confirm Dialog',
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
            CommonButton.primary(
              label: 'Show Bottom Sheet',
              onPressed: () {
                CommonBottomSheet.show<void>(
                  context,
                  title: 'My Bottom Sheet',
                  child: Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: Text('Sheet Content Goes Here', style: context.bodyRegular16()),
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
            CommonButton.primary(
              label: 'Show Success Snackbar',
              onPressed: () {
                context.showSuccessSnackBar('Operation completed successfully!');
              },
            ),
            Gap.medium16,
            CommonButton.primary(
              label: 'Show Error Snackbar',
              onPressed: () {
                context.showErrorSnackBar('Something went wrong!');
              },
            ),
            Gap.medium16,
            CommonButton.primary(
              label: 'Show Custom Snackbar',
              onPressed: () {
                context.showCustomSnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Gap.small8,
                      Expanded(
                        child: Text(
                          'You earned 50 points!',
                          style: context.bodyMedium14(color: Colors.white),
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
            CommonButton.primary(
              label: 'Show Toast (Bottom)',
              onPressed: () {
                context.showToast('This is a toast message');
              },
            ),
            Gap.medium16,
            CommonButton.primary(
              label: 'Show Toast (Top)',
              onPressed: () {
                context.showToast('Top Toast', gravity: ToastGravity.top);
              },
            ),
            Gap.medium16,
            CommonButton.primary(
              label: 'Show Success Toast',
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
            CommonButton.primary(
              label: 'Show Long Toast (3.5s)',
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
