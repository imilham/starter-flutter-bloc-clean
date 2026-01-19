import 'package:flutter/material.dart';
import 'package:starter/more/view/samples/sample_section.dart';
import 'package:starter/utils/utils.dart';

class LocalizationSample extends StatelessWidget {
  const LocalizationSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Localization',
          style: context.textTheme.headlineMedium,
        ),
        Gap.small8,
        Text(
          'Manage app text and languages efficiently.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Gap.medium16,
        const _InfoBanner(),
        Gap.medium16,
        const _LivePreviewSection(),
        Gap.medium16,
        const Divider(),
        Gap.medium16,
        Text(
          'Developer Guide',
          style: context.textTheme.titleLarge,
        ),
        Gap.medium16,
        const SampleSection(
          title: 'How to Add New Strings',
          icon: Icons.edit_note,
          children: [
            _StepItem(
              step: '1',
              title: 'Add to ARB',
              description: 'Open lib/l10n/arb/app_en.arb and add your key-value pair.',
            ),
            _StepItem(
              step: '2',
              title: 'Generate',
              description: 'Save (auto-generates) or run "flutter gen-l10n".',
            ),
            _StepItem(
              step: '3',
              title: 'Use in Code',
              description: 'Use context.l10n.yourKeyName.',
            ),
          ],
        ),
        const SampleSection(
          title: 'How to Add a New Language',
          icon: Icons.language,
          children: [
            _StepItem(
              step: '1',
              title: 'Create ARB File',
              description: 'Create lib/l10n/arb/app_es.arb.',
            ),
            _StepItem(
              step: '2',
              title: 'Translate',
              description: 'Copy content from English ARB and translate.',
            ),
            _StepItem(
              step: '3',
              title: 'Generate',
              description: 'Run "flutter gen-l10n" to update delegates.',
            ),
          ],
        ),
        const SampleSection(
          title: 'How it Works',
          icon: Icons.architecture,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '• ARB Files store string resources.\n'
                '• `flutter gen-l10n` compiles them into Dart code.\n'
                '• `MaterialApp` uses the generated delegates to provide localized strings via `context` inheritance.',
              ),
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
        color: context.colorScheme.primaryContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.primary.withOpacity(0.2),
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
                  'Looking for full multi-language support?',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
                Gap.small8,
                Text(
                  'Checkout the `feature/localization-imilham` branch for a complete example including Spanish translations and a runtime language switcher.',
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

class _LivePreviewSection extends StatelessWidget {
  const _LivePreviewSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: context.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.preview, size: 20, color: context.colorScheme.primary),
                Gap.small8,
                Text(
                  'Live Preview',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Gap.medium16,
            _ExampleItem(
              keyName: 'myExampleTextOne',
              value: context.l10n.myExampleTextOne,
            ),
            Gap.small8,
            _ExampleItem(
              keyName: 'myExampleTextTwo',
              value: context.l10n.myExampleTextTwo,
            ),
          ],
        ),
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

class _ExampleItem extends StatelessWidget {
  const _ExampleItem({
    required this.keyName,
    required this.value,
  });

  final String keyName;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Text(
            keyName,
            style: context.textTheme.labelMedium?.copyWith(
              fontFamily: 'monospace',
              color: context.colorScheme.primary,
            ),
          ),
          const Spacer(),
          Text(
            '"$value"',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
