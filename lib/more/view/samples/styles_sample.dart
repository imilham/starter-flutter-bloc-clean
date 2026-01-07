import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

// TODO: remove-samples-im

class StylesSample extends StatelessWidget {
  const StylesSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionHeader.large('Colors'),
        const Text('Material Color Scheme', style: TextStyle(fontSize: 14)), // or bodySmall14()
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
            _ColorChip(
              name: 'Example',
              color: context.appColors.exampleColor,
            ),
          ],
        ),
        const Divider(height: 32),
        const SectionHeader.large('Typography (styles.dart)'),
        const Text('These are the standard semantic styles used throughout the app.'),
        Gap.medium16,

        const SectionHeader.small('Headlines'),
        _TypeSample(style: headline32(), name: 'headline1'),
        _TypeSample(style: headline24(), name: 'headline2'),
        _TypeSample(style: headline20(), name: 'headline3'),
        _TypeSample(style: headline16(), name: 'headline4'),
        _TypeSample(style: headline14(), name: 'headline5'),
        _TypeSample(style: headline12(), name: 'headline6'),

        const SectionHeader.small('Body'),
        _TypeSample(style: bodyRegular16(), name: 'bodyRegular'),
        _TypeSample(style: bodySmall14(), name: 'bodySmall'),
        _TypeSample(style: bodyXSmall12(), name: 'bodyXSmall'),

        const SectionHeader.small('Buttons'),
        _TypeSample(style: buttonRegular16(textColor: context.colorScheme.onSurface), name: 'buttonRegular'),
        _TypeSample(style: buttonSmall14(textColor: context.colorScheme.onSurface), name: 'buttonSmall'),
        _TypeSample(style: buttonXSmall12(textColor: context.colorScheme.onSurface), name: 'buttonXSmall'),

        const SectionHeader.small('Form'),
        _TypeSample(style: formLabel14(textColor: context.colorScheme.onSurface), name: 'formLabel'),
        _TypeSample(style: formBody16(textColor: context.colorScheme.onSurface), name: 'formBody'),
        _TypeSample(style: formHint16(textColor: context.colorScheme.onSurface.withValues(alpha: 0.5)), name: 'formHint'),

        const SectionHeader.small('AppBar'),
        _TypeSample(style: appBar16(textColor: context.colorScheme.onSurface), name: 'appBar'),
        _TypeSample(style: appBarDescription12(textColor: context.colorScheme.onSurface), name: 'appBarDescription'),

        const SectionHeader.small('Tabs'),
        _TypeSample(style: tab10(textColor: context.colorScheme.onSurface), name: 'tab3Xs'),

        const Divider(height: 32),
        const SectionHeader.large('Usage Examples'),
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
            borderRadius: BorderRadius.circular(12),
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
