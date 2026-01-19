import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

class LocalizationSample extends StatelessWidget {
  const LocalizationSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedColumn(
      children: [
        Text(
          'Localization Guide',
          style: context.textTheme.headlineMedium,
        ),
        const Text(
          'Follow these steps to add new strings:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const _StepItem(
          step: '1',
          title: 'Add to ARB',
          description: 'Open lib/l10n/arb/app_en.arb and add your key-value pair.',
        ),
        Gap.medium16,
        const _StepItem(
          step: '2',
          title: 'Generate',
          description: 'Save the file (Flutter extension auto-generates) or run "flutter gen-l10n".',
        ),
        Gap.medium16,
        const _StepItem(
          step: '3',
          title: 'Use in Code',
          description: 'Use context.l10n.yourKeyName to access the string.',
        ),
        const Divider(),
        Text(
          'Live Examples',
          style: context.textTheme.headlineSmall,
        ),
        _ExampleItem(
          keyName: 'myExampleTextOne',
          value: context.l10n.myExampleTextOne,
        ),
        Gap.medium16,
        _ExampleItem(
          keyName: 'myExampleTextTwo',
          value: context.l10n.myExampleTextTwo,
        ),
        Gap.medium16,
        _ExampleItem(
          keyName: 'myExampleTextThree',
          value: context.l10n.myExampleTextThree,
        ),
        Gap.extraLarge32,
        const Divider(),
        Gap.extraLarge32,
        Text(
          'Adding a New Language',
          style: context.textTheme.headlineLarge,
        ),
        const Text(
          'Follow these steps to add a new language (e.g. Spanish):',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const _StepItem(
          step: '1',
          title: 'Create ARB File',
          description: 'Create a new file lib/l10n/arb/app_es.arb.',
        ),
        Gap.medium16,
        const _StepItem(
          step: '2',
          title: 'Translate',
          description: 'Copy content from app_en.arb and translate values.',
        ),
        Gap.medium16,
        const _StepItem(
          step: '3',
          title: 'Generate',
          description: 'Run "flutter gen-l10n" to generate the new delegate.',
        ),
        Gap.extraLarge32,
        const Divider(),
        Gap.extraLarge32,
        Text(
          'Changing the Language',
          style: context.textTheme.headlineLarge,
        ),
        const Text(
          'The app automatically detects and uses the system language. To change the language, go to your device settings and change the language preference.',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Gap.extraLarge32,
        const Divider(),
        Gap.extraLarge32,
        Text(
          'How it Works',
          style: context.textTheme.headlineLarge,
        ),
        const Text(
          'The MaterialApp is configured with `localizationsDelegates` and `supportedLocales` from the generated `AppLocalizations` class. This ensures that the correct translation is loaded based on the device\'s locale setting.',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: context.colorScheme.primaryContainer,
          child: Text(
            step,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gap.medium16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.textTheme.titleMedium),
              Text(description, style: context.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, size: 16, color: context.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'context.l10n.$keyName',
                style: context.textTheme.labelLarge?.copyWith(
                  fontFamily: 'monospace',
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Output: "$value"',
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
