import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

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
            Gap.medium16,
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

  TextStyle? _getStyle(BuildContext context) {
    final baseColor = color ?? context.colorScheme.onSurface;

    switch (style) {
      case SectionHeaderStyle.large:
        // Large headers often look good in Primary color, but let's stick to standard text color unless overridden
        // Or we can default to Primary as per your local _SectionHeader implementation
        return context.titleLarge?.bold.copyWith(
          color: color ?? context.colorScheme.primary, // Keeping your local preference
        );
      case SectionHeaderStyle.medium:
        return context.titleMedium?.bold.copyWith(color: baseColor);
      case SectionHeaderStyle.small:
        return context.labelLarge?.bold.copyWith(color: baseColor);
    }
  }
}
