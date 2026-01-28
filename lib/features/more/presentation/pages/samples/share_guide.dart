import 'package:flutter/material.dart';
import 'package:starter/features/more/presentation/pages/samples/sample_section.dart';
import 'package:starter/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareGuide extends StatelessWidget {
  const ShareGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'App Sharing',
          style: context.textTheme.headlineMedium,
        ),
        Gap.small8,
        Text(
          'Share content, links, or files using the share_plus package.',
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
        const SampleSection(
          title: 'Setup',
          icon: Icons.settings_applications,
          children: [
            _StepItem(
              step: '1',
              title: 'Add Dependency',
              description: 'Add `share_plus` to your pubspec.yaml.',
              url: 'https://pub.dev/packages/share_plus',
              urlLabel: 'View share_plus package',
              code: '''
dependencies:
  share_plus: ^9.0.0''',
            ),
            _StepItem(
              step: '2',
              title: 'Import Package',
              description: 'Import the package in your dart file.',
              code: '''
import 'package:share_plus/share_plus.dart';''',
            ),
          ],
        ),
        const SampleSection(
          title: 'Implementation',
          icon: Icons.code,
          children: [
            _StepItem(
              step: '3',
              title: 'Share Text/Link',
              description: 'Use `Share.share` to open the share sheet.',
              code: '''
Share.share('Check out this website https://example.com');''',
            ),
            _StepItem(
              step: '4',
              title: 'Share Files',
              description: 'Use `Share.shareXFiles` to share images or documents.',
              code: '''
final result = await Share.shareXFiles([
  XFile('path/to/file.png'),
]);
  
if (result.status == ShareResultStatus.success) {
    print('Thank you for sharing!');
}''',
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
                  'Documentation Only',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
                Gap.small8,
                Text(
                  'This is a lightweight guide to avoid adding heavy dependencies to the starter kit. Follow the steps below to implement it yourself.',
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
    this.url,
    this.urlLabel,
    this.code,
  });

  final String step;
  final String title;
  final String description;
  final String? url;
  final String? urlLabel;
  final String? code;

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
                if (url != null && urlLabel != null) ...[
                  Gap.small8,
                  GestureDetector(
                    onTap: () => launchUrl(Uri.parse(url!)),
                    child: Text(
                      urlLabel!,
                      style: context.textTheme.labelLarge?.copyWith(
                        color: context.colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
                if (code != null) ...[
                  Gap.small8,
                  _CodeSnippet(code: code!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  const _CodeSnippet({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colorScheme.outlineVariant,
        ),
      ),
      child: SelectableText(
        code,
        style: TextStyle(
          fontFamily: 'Courier',
          fontSize: 12,
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
