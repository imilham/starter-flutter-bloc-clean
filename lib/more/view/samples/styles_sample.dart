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
        const Text('Material Color Scheme'),
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
        const Text('Custom App Colors (ThemeExtension)'),
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
        const SectionHeader.large('Typography'),
        _TypeSample(style: context.displaySmall, name: 'Display Small'),
        _TypeSample(style: context.headlineMedium, name: 'Headline Medium'),
        _TypeSample(style: context.headlineSmall, name: 'Headline Small'),
        _TypeSample(style: context.titleMedium, name: 'Title Medium'),
        const Divider(),
        _TypeSample(style: context.bodyLarge, name: 'Body Large'),
        _TypeSample(style: context.bodyLarge?.bold, name: 'Body Large Bold'),
        Gap.small8,
        _TypeSample(style: context.bodyMedium, name: 'Body Medium'),
        _TypeSample(style: context.bodyMedium?.bold, name: 'Body Medium Bold'),
        Gap.small8,
        _TypeSample(style: context.bodySmall, name: 'Body Small'),
        _TypeSample(style: context.bodySmall?.bold, name: 'Body Small Bold'),
        Gap.small8,
        _TypeSample(style: context.labelSmall, name: 'Label Small'),
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
        Text(name, style: context.labelSmall),
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
                  style: context.bodySmall?.copyWith(color: Colors.grey.shade600),
                ),
                Text(
                  '${style?.fontSize?.toStringAsFixed(0)}sp',
                  style: context.labelSmall?.copyWith(color: Colors.grey.shade400),
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
