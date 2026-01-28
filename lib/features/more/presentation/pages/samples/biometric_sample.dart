import 'package:flutter/material.dart';
import 'package:starter/features/more/presentation/pages/samples/sample_section.dart';
import 'package:starter/utils/utils.dart';


class BiometricSample extends StatelessWidget {
  const BiometricSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Biometric Authentication',
          style: context.textTheme.headlineMedium,
        ),
        Gap.small8,
        Text(
          'Secure access using FaceID or Fingerprint.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Gap.medium16,
        const _InfoBanner(),
        Gap.medium16,
        const Divider(),
        Gap.medium16,

        Text(
          'Developer Guide',
          style: context.textTheme.titleLarge,
        ),
        Gap.medium16,

        // Guide Steps
        const SampleSection(
          title: 'Setup & Configuration',
          icon: Icons.settings_applications,
          children: [
            _StepItem(
              step: '1',
              title: 'Add Dependency',
              description: 'Add `local_auth` to your pubspec.yaml.',
            ),
            _StepItem(
              step: '2',
              title: 'Android Config',
              description: 'Update `AndroidManifest.xml` to include `USE_BIOMETRIC` permission and `MainActivity` class changes if needed (FragmentActivity).',
            ),
            _StepItem(
              step: '3',
              title: 'iOS Config',
              description: 'Add `NSFaceIDUsageDescription` key to `Info.plist`.',
            ),
          ],
        ),
        
        const SampleSection(
          title: 'Implementation',
          icon: Icons.code,
          children: [
             _StepItem(
              step: '4',
              title: 'Controller',
              description: 'Use `BiometricController` to wrap `LocalAuthentication` logic explicitly.',
            ),
             _StepItem(
              step: '5',
              title: 'Authenticate',
              description: 'Call `authenticate()` with a localized reason string.',
            ),
          ],
        ),
      ],
    );
  }
}


class _InfoBanner extends StatelessWidget {
  const _InfoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info, color: context.colorScheme.primary),
          Gap.medium16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need full login integration?',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
                Gap.small8,
                  Text(
                  'This is a guide only. For the full implementation and live demo, please check the `biometric` branch.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  const _StepItem({
    required this.step,
    required this.title,
    required this.description,
  });

  final String step;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colorScheme.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Text(
              step,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Gap.medium16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
