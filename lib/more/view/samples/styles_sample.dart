import 'package:flutter/material.dart';
import 'package:starter/more/view/samples/sample_section.dart';
import 'package:starter/utils/utils.dart';

// TODO: remove-samples-im

class StylesSample extends StatelessWidget {
  const StylesSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'App Styles',
          style: context.textTheme.headlineMedium,
        ),
        Gap.small8,
        Text(
          'Core design tokens and typography.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Gap.medium16,
        SampleSection(
          title: 'Colors',
          icon: Icons.palette,
          isExpanded: true,
          children: [
            const Text('Material Color Scheme', style: TextStyle(fontSize: 14)),
            Gap.small8,
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _ColorChip(name: 'Primary', color: context.colorScheme.primary),
                _ColorChip(name: 'Secondary', color: context.colorScheme.secondary),
                _ColorChip(name: 'Surface', color: context.colorScheme.surface),
                _ColorChip(name: 'Error', color: context.colorScheme.error),
              ],
            ),
            Gap.large24,
            const Text('Custom App Colors (ThemeExtension)', style: TextStyle(fontSize: 14)),
            Gap.small8,
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _ColorChip(
                  name: 'Shimmer',
                  color: context.appColors.shimmerColor,
                ),
                _ColorChip(
                  name: 'Shimmer BG',
                  color: context.appColors.shimmerBgColor,
                ),
              ],
            ),
          ],
        ),
        SampleSection(
          title: 'Typography',
          icon: Icons.text_fields,
          children: [
            const SectionHeader.small('Headlines'),
            _TypeSample(style: headline32(), name: 'headline32()'),
            _TypeSample(style: headline24(), name: 'headline24()'),
            _TypeSample(style: headline20(), name: 'headline20()'),
            _TypeSample(style: headline16(), name: 'headline16()'),
            _TypeSample(style: headline14(), name: 'headline14()'),
            _TypeSample(style: headline12(), name: 'headline12()'),
            Gap.medium16,
            const SectionHeader.small('Body'),
            _TypeSample(style: bodyRegular16(), name: 'bodyRegular16()'),
            _TypeSample(style: bodySmall14(), name: 'bodySmall14()'),
            _TypeSample(style: bodyXSmall12(), name: 'bodyXSmall12()'),
            Gap.medium16,
            const SectionHeader.small('Buttons'),
            _TypeSample(style: buttonRegular16(textColor: context.colorScheme.onSurface), name: 'buttonRegular16()'),
            _TypeSample(style: buttonSmall14(textColor: context.colorScheme.onSurface), name: 'buttonSmall14()'),
            _TypeSample(style: buttonXSmall12(textColor: context.colorScheme.onSurface), name: 'buttonXSmall12()'),
            Gap.medium16,
            const SectionHeader.small('Form'),
            _TypeSample(style: formLabel14(textColor: context.colorScheme.onSurface), name: 'formLabel14()'),
            _TypeSample(style: bodyRegular16(textColor: context.colorScheme.onSurface), name: 'formBody (bodyRegular16)'),
            _TypeSample(style: formHint16(textColor: context.colorScheme.onSurface.withValues(alpha: 0.5)), name: 'formHint16()'),
            Gap.medium16,
            const SectionHeader.small('Tabs'),
            _TypeSample(style: tab10(textColor: context.colorScheme.onSurface), name: 'tab10()'),
          ],
        ),
        SampleSection(
          title: 'Usage Examples',
          icon: Icons.code,
          children: [
            const Text('Passing parameters overrides defaults:'),
            Gap.small8,
            _TypeSample(
              style: bodyRegular16(fontWeight: FontWeight.bold),
              name: 'bodyRegular16(fontWeight: FontWeight.bold)',
            ),
            _TypeSample(
              style: bodyRegular16(fontStyle: FontStyle.italic),
              name: 'bodyRegular16(fontStyle: FontStyle.italic)',
            ),
            _TypeSample(
              style: bodyRegular16(textColor: context.colorScheme.error),
              name: 'bodyRegular16(textColor: context.colorScheme.error)',
            ),
          ],
        ),
      ],
    );
  }
}

class _ColorChip extends StatelessWidget {
  const _ColorChip({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppRadius.medium12,
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
        ),
        Gap.extraSmall4,
        Text(
          name,
          style: tab10(fontWeight: FontWeight.bold, textColor: context.colorScheme.onSurface),
        ),
      ],
    );
  }
}

class _TypeSample extends StatelessWidget {
  const _TypeSample({required this.style, required this.name});

  final TextStyle? style;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: bodyXSmall12(textColor: Colors.grey.shade600),
                ),
                Text(
                  '${style?.fontSize?.toStringAsFixed(0)}sp',
                  style: tab10(textColor: Colors.grey.shade400),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Quick Brown Fox',
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

