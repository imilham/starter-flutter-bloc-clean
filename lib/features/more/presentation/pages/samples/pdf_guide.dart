import 'package:flutter/material.dart';
import 'package:starter/features/more/presentation/pages/samples/sample_section.dart';
import 'package:starter/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfGuide extends StatelessWidget {
  const PdfGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'PDF Generation',
          style: context.textTheme.headlineMedium,
        ),
        Gap.small8,
        Text(
          'Create and print documents using the pdf and printing packages.',
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
              title: 'Add Dependencies',
              description: 'Add `pdf` and `printing` to your pubspec.yaml.',
              url: 'https://pub.dev/packages/pdf',
              urlLabel: 'View pdf package',
              code: '''
dependencies:
  pdf: ^3.10.8
  printing: ^5.11.0''',
            ),
            _StepItem(
              step: '2',
              title: 'Import Packages',
              description: 'Import the necessary packages in your dart file.',
              code: '''
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';''',
            ),
          ],
        ),
        const SampleSection(
          title: 'Implementation',
          icon: Icons.code,
          children: [
            _StepItem(
              step: '3',
              title: 'Create Document',
              description: 'Create a `pw.Document` and add pages using `pw.Page` widgets.',
              code: '''
final doc = pw.Document();

doc.addPage(
  pw.Page(
    build: (pw.Context context) {
      return pw.Center(
        child: pw.Text('Hello World'),
      );
    },
  ),
);''',
            ),
            _StepItem(
              step: '4',
              title: 'Preview & Print',
              description: 'Use `Printing.layoutPdf` to open the print/share dialog.',
              code: '''
await Printing.layoutPdf(
  onLayout: (format) async => doc.save(),
);''',
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
