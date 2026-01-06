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
        const Text('Material Color Scheme', style: TextStyle(fontSize: 14)), // or bodySmall()
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
        const Divider(height: 32),
        const SectionHeader.large('Typography (styles.dart)'),
        const Text('These are the standard semantic styles used throughout the app.'),
        Gap.medium16,

        const SectionHeader.small('Headlines'),
        _TypeSample(style: headline1(), name: 'headline1'),
        _TypeSample(style: headline2(), name: 'headline2'),
        _TypeSample(style: headline3(), name: 'headline3'),
        _TypeSample(style: headline4(), name: 'headline4'),
        _TypeSample(style: headline5(), name: 'headline5'),
        _TypeSample(style: headline6(), name: 'headline6'),

        const SectionHeader.small('Body'),
        _TypeSample(style: bodyRegular(), name: 'bodyRegular'),
        _TypeSample(style: bodySmall(), name: 'bodySmall'),
        _TypeSample(style: bodyXSmall(), name: 'bodyXSmall'),

        const SectionHeader.small('Buttons'),
        _TypeSample(style: buttonRegular(textColor: context.colorScheme.onSurface), name: 'buttonRegular'),
        _TypeSample(style: buttonSmall(textColor: context.colorScheme.onSurface), name: 'buttonSmall'),
        _TypeSample(style: buttonXSmall(textColor: context.colorScheme.onSurface), name: 'buttonXSmall'),

        const SectionHeader.small('Form'),
        _TypeSample(style: formLabel(textColor: context.colorScheme.onSurface), name: 'formLabel'),
        _TypeSample(style: formBody(textColor: context.colorScheme.onSurface), name: 'formBody'),
        _TypeSample(style: formHint(textColor: context.colorScheme.onSurface.withValues(alpha: 0.5)), name: 'formHint'),

        const SectionHeader.small('AppBar'),
        _TypeSample(style: appBar(textColor: context.colorScheme.onSurface), name: 'appBar'),
        _TypeSample(style: appBarDescription(textColor: context.colorScheme.onSurface), name: 'appBarDescription'),

        const SectionHeader.small('Tabs'),
        _TypeSample(style: tab3Xs(textColor: context.colorScheme.onSurface), name: 'tab3Xs'),

        const Divider(height: 32),
        const SectionHeader.large('Usage Examples'),
        const Text('Passing parameters overrides defaults:'),
        Gap.small8,
        _TypeSample(
          style: bodyRegular(fontWeight: FontWeight.bold),
          name: 'bodyRegular(fontWeight: FontWeight.bold)',
        ),
        _TypeSample(
          style: bodyRegular(fontStyle: FontStyle.italic),
          name: 'bodyRegular(fontStyle: FontStyle.italic)',
        ),
        _TypeSample(
          style: bodyRegular(textColor: context.colorScheme.error),
          name: 'bodyRegular(textColor: context.colorScheme.error)',
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
          style: tab3Xs(fontWeight: FontWeight.bold, textColor: context.colorScheme.onSurface),
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
                  style: bodyXSmall(textColor: Colors.grey.shade600),
                ),
                Text(
                  '${style?.fontSize?.toStringAsFixed(0)}sp',
                  style: tab3Xs(textColor: Colors.grey.shade400),
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
