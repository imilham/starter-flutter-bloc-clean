import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart' as gap_pkg;

/// App-wide spacing constants for consistent layouts.
///
/// Use these constants instead of hardcoded values for consistent spacing.
///
/// ## Usage
/// ```dart
/// // Using size directly
/// SizedBox(height: AppSpacing.md16)
///
/// // Using pre-defined EdgeInsets
/// Padding(padding: AppSpacing.allMd16)
/// Padding(padding: AppSpacing.horizontalLg24)
///
/// // Using with Gap
/// Gap(AppSpacing.sm8)
/// ```
class AppSpacing {
  AppSpacing._();

  // ─────────────────────────────────────────────────────────────────────
  // SIZE VALUES
  // ─────────────────────────────────────────────────────────────────────

  /// Extra small spacing: 4px
  static const double xs4 = 4;

  /// Small spacing: 8px
  static const double sm8 = 8;

  /// Medium-small spacing: 12px
  static const double md12 = 12;

  /// Medium spacing: 16px (default)
  static const double md16 = 16;

  /// Large spacing: 24px
  static const double lg24 = 24;

  /// Extra large spacing: 32px
  static const double xl32 = 32;

  /// Double extra large spacing: 48px
  static const double xxl48 = 48;

  // ─────────────────────────────────────────────────────────────────────
  // EDGE INSETS - HORIZONTAL
  // ─────────────────────────────────────────────────────────────────────

  /// Horizontal padding: 4px
  static const horizontalXs4 = EdgeInsets.symmetric(horizontal: xs4);

  /// Horizontal padding: 8px
  static const horizontalSm8 = EdgeInsets.symmetric(horizontal: sm8);

  /// Horizontal padding: 12px
  static const horizontalMd12 = EdgeInsets.symmetric(horizontal: md12);

  /// Horizontal padding: 16px (default)
  static const horizontalMd16 = EdgeInsets.symmetric(horizontal: md16);

  /// Horizontal padding: 24px
  static const horizontalLg24 = EdgeInsets.symmetric(horizontal: lg24);

  // ─────────────────────────────────────────────────────────────────────
  // EDGE INSETS - VERTICAL
  // ─────────────────────────────────────────────────────────────────────

  /// Vertical padding: 4px
  static const verticalXs4 = EdgeInsets.symmetric(vertical: xs4);

  /// Vertical padding: 8px
  static const verticalSm8 = EdgeInsets.symmetric(vertical: sm8);

  /// Vertical padding: 12px
  static const verticalMd12 = EdgeInsets.symmetric(vertical: md12);

  /// Vertical padding: 16px (default)
  static const verticalMd16 = EdgeInsets.symmetric(vertical: md16);

  /// Vertical padding: 24px
  static const verticalLg24 = EdgeInsets.symmetric(vertical: lg24);

  // ─────────────────────────────────────────────────────────────────────
  // EDGE INSETS - ALL
  // ─────────────────────────────────────────────────────────────────────

  /// All padding: 8px
  static const allSm8 = EdgeInsets.all(sm8);

  /// All padding: 12px
  static const allMd12 = EdgeInsets.all(md12);

  /// All padding: 16px (default)
  static const allMd16 = EdgeInsets.all(md16);

  /// All padding: 24px
  static const allLg24 = EdgeInsets.all(lg24);
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
///     Gap.small8,  // 8px vertical gap
///     Text('World'),
///   ],
/// )
///
/// Row(
///   children: [
///     Icon(Icons.star),
///     Gap.extraSmall4,  // 4px horizontal gap
///     Text('Starred'),
///   ],
/// )
/// ```
class Gap {
  Gap._();

  /// 2px gap
  static const extraSmall2 = gap_pkg.Gap(2);

  /// 4px gap
  static const extraSmall4 = gap_pkg.Gap(4);

  /// 8px gap
  static const small8 = gap_pkg.Gap(8);

  /// 12px gap
  static const medium12 = gap_pkg.Gap(12);

  /// 16px gap
  static const medium16 = gap_pkg.Gap(16);

  /// 24px gap
  static const large24 = gap_pkg.Gap(24);

  /// 32px gap
  static const extraLarge32 = gap_pkg.Gap(32);
}
