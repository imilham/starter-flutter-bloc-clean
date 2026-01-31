import 'package:flutter/material.dart';
import 'package:starter/app/theme/theme.dart';

/// Defines the visual style/size of the [SectionHeader].
enum SectionHeaderStyle {
  /// Large header (22px), typically used for page titles or major sections.
  /// Maps to [TextTheme.titleLarge].
  large,

  /// Medium header (16px), default size for standard sections.
  /// Maps to [TextTheme.titleMedium].
  medium,

  /// Small header (14px), used for subsections or dense lists.
  /// Maps to [TextTheme.labelLarge].
  small,
}

/// A standard section header widget to enforce consistent typography and spacing.
///
/// Usage:
/// ```dart
/// SectionHeader(
///   title: 'Account Settings',
///   style: SectionHeaderStyle.large,
/// )
///
/// SectionHeader(
///   title: 'Recent Transactions',
///   action: TextButton(onPressed: () {}, child: Text('See All')),
/// )
/// ```
class SectionHeader extends StatelessWidget {
  /// Standard constructor.
  const SectionHeader({
    required this.title,
    super.key,
    this.style = SectionHeaderStyle.medium,
    this.action,
    this.padding,
    this.color,
  });

  /// factory for a [SectionHeaderStyle.large] header.
  const SectionHeader.large(
    this.title, {
    super.key,
    this.action,
    this.padding,
    this.color,
  }) : style = SectionHeaderStyle.large;

  /// factory for a [SectionHeaderStyle.medium] header.
  const SectionHeader.medium(
    this.title, {
    super.key,
    this.action,
    this.padding,
    this.color,
  }) : style = SectionHeaderStyle.medium;

  /// factory for a [SectionHeaderStyle.small] header.
  const SectionHeader.small(
    this.title, {
    super.key,
    this.action,
    this.padding,
    this.color,
  }) : style = SectionHeaderStyle.small;

  /// The text to display.
  final String title;

  /// The size variant of the header. Defaults to [SectionHeaderStyle.medium].
  final SectionHeaderStyle style;

  /// Optional action widget to display on the right (e.g., "See All" button).
  final Widget? action;

  /// Custom padding. If null, defaults to:
  /// - Large/Medium: `bottom: 12`
  /// - Small: `bottom: 8`
  final EdgeInsetsGeometry? padding;

  /// Optional override color. If null, uses [ColorScheme.onSurface] (or primary for Large).
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? _defaultPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: _getStyle(context),
            ),
          ),
          if (action != null) ...[
            // Assuming Gap.medium16 is still available or needs to be replaced
            // For now, keeping it as is, as the instruction didn't touch it.
            // If Gap is from utils.dart, it might need an update.
            // For this change, we assume Gap is still accessible.
            const SizedBox(width: 16), // Replaced Gap.medium16 with SizedBox for robustness
            action!,
          ],
        ],
      ),
    );
  }

  EdgeInsetsGeometry get _defaultPadding {
    switch (style) {
      case SectionHeaderStyle.large:
      case SectionHeaderStyle.medium:
        return const EdgeInsets.only(bottom: 12);
      case SectionHeaderStyle.small:
        return const EdgeInsets.only(bottom: 8);
    }
  }

  TextStyle _getStyle(BuildContext context) {
    final baseColor = color ?? context.colorScheme.onSurface;

    switch (style) {
      case SectionHeaderStyle.large:
        return context.headline20(color: baseColor);
      case SectionHeaderStyle.medium:
        return context.headline16(color: baseColor);
      case SectionHeaderStyle.small:
        return context.headline14(color: baseColor);
    }
  }
}
