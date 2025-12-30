import 'package:flutter/widgets.dart';

/// App-wide spacing constants for consistent layouts.
///
/// Use these constants instead of hardcoded values for consistent spacing.
///
/// ## Usage
/// ```dart
/// const FixedGap(mainAxisExtent: AppSpacing.md)
/// Padding(padding: AppSpacing.horizontalMd)
/// ```
class AppSpacing {
  AppSpacing._();

  // ─────────────────────────────────────────────────────────────────────
  // SIZE VALUES
  // ─────────────────────────────────────────────────────────────────────

  /// Extra small spacing: 4px
  static const double xs = 4;

  /// Small spacing: 8px
  static const double sm = 8;

  /// Medium spacing: 16px (default)
  static const double md = 16;

  /// Large spacing: 24px
  static const double lg = 24;

  /// Extra large spacing: 32px
  static const double xl = 32;

  /// Double extra large spacing: 48px
  static const double xxl = 48;

  // ─────────────────────────────────────────────────────────────────────
  // EDGE INSETS - HORIZONTAL
  // ─────────────────────────────────────────────────────────────────────

  /// Horizontal padding: 4px
  static const horizontalXs = EdgeInsets.symmetric(horizontal: xs);

  /// Horizontal padding: 8px
  static const horizontalSm = EdgeInsets.symmetric(horizontal: sm);

  /// Horizontal padding: 16px (default)
  static const horizontalMd = EdgeInsets.symmetric(horizontal: md);

  /// Horizontal padding: 24px
  static const horizontalLg = EdgeInsets.symmetric(horizontal: lg);

  // ─────────────────────────────────────────────────────────────────────
  // EDGE INSETS - VERTICAL
  // ─────────────────────────────────────────────────────────────────────

  /// Vertical padding: 4px
  static const verticalXs = EdgeInsets.symmetric(vertical: xs);

  /// Vertical padding: 8px
  static const verticalSm = EdgeInsets.symmetric(vertical: sm);

  /// Vertical padding: 16px (default)
  static const verticalMd = EdgeInsets.symmetric(vertical: md);

  /// Vertical padding: 24px
  static const verticalLg = EdgeInsets.symmetric(vertical: lg);

  // ─────────────────────────────────────────────────────────────────────
  // EDGE INSETS - ALL
  // ─────────────────────────────────────────────────────────────────────

  /// All padding: 8px
  static const allSm = EdgeInsets.all(sm);

  /// All padding: 16px (default)
  static const allMd = EdgeInsets.all(md);

  /// All padding: 24px
  static const allLg = EdgeInsets.all(lg);
}

/// Pre-built gap widgets for consistent spacing in layouts.
///
/// These work in both Row (horizontal) and Column (vertical) widgets.
/// The gap automatically adapts based on the parent's main axis.
///
/// ## Usage
/// ```dart
/// Column(
///   children: [
///     Text('Hello'),
///     Gap.sm,  // 8px vertical gap
///     Text('World'),
///   ],
/// )
///
/// Row(
///   children: [
///     Icon(Icons.star),
///     Gap.xs,  // 4px horizontal gap
///     Text('Starred'),
///   ],
/// )
/// ```
class Gap {
  Gap._();

  /// 2px gap
  static const extraSmall2 = SizedBox.square(dimension: 2);

  /// 4px gap
  static const extraSmall4 = SizedBox.square(dimension: 4);

  /// 8px gap
  static const small8 = SizedBox.square(dimension: 8);

  /// 12px gap
  static const medium12 = SizedBox.square(dimension: 12);

  /// 16px gap
  static const medium16 = SizedBox.square(dimension: 16);

  /// 24px gap
  static const large24 = SizedBox.square(dimension: 24);

  /// 32px gap
  static const extraLarge32 = SizedBox.square(dimension: 32);
}
