import 'package:flutter/widgets.dart';
import 'package:starter/utils/constants/spacing.dart';

/// Extension to provide convenient padding methods on widgets.
///
/// Usage:
/// ```dart
/// Text('Hello').paddingAll16
/// Text('Hello').paddingHorizontal16
/// Text('Hello').paddingVertical8
/// ```
extension WidgetPaddingExtension on Widget {
  // ─────────────────────────────────────────────────────────────────────
  // ALL SIDES
  // ─────────────────────────────────────────────────────────────────────

  /// 4px padding on all sides
  Widget get paddingAll4 => Padding(padding: const EdgeInsets.all(AppSpacing.xs4), child: this);

  /// 8px padding on all sides
  Widget get paddingAll8 => Padding(padding: const EdgeInsets.all(AppSpacing.sm8), child: this);

  /// 12px padding on all sides
  Widget get paddingAll12 => Padding(padding: const EdgeInsets.all(AppSpacing.md12), child: this);

  /// 16px padding on all sides
  Widget get paddingAll16 => Padding(padding: const EdgeInsets.all(AppSpacing.md16), child: this);

  /// 24px padding on all sides
  Widget get paddingAll24 => Padding(padding: const EdgeInsets.all(AppSpacing.lg24), child: this);

  /// 32px padding on all sides
  Widget get paddingAll32 => Padding(padding: const EdgeInsets.all(AppSpacing.xl32), child: this);

  // ─────────────────────────────────────────────────────────────────────
  // HORIZONTAL
  // ─────────────────────────────────────────────────────────────────────

  /// 4px horizontal padding
  Widget get paddingHorizontal4 => Padding(padding: AppSpacing.horizontalXs4, child: this);

  /// 8px horizontal padding
  Widget get paddingHorizontal8 => Padding(padding: AppSpacing.horizontalSm8, child: this);

  /// 12px horizontal padding
  Widget get paddingHorizontal12 => Padding(padding: AppSpacing.horizontalMd12, child: this);

  /// 16px horizontal padding
  Widget get paddingHorizontal16 => Padding(padding: AppSpacing.horizontalMd16, child: this);

  /// 24px horizontal padding
  Widget get paddingHorizontal24 => Padding(padding: AppSpacing.horizontalLg24, child: this);

  // ─────────────────────────────────────────────────────────────────────
  // VERTICAL
  // ─────────────────────────────────────────────────────────────────────

  /// 4px vertical padding
  Widget get paddingVertical4 => Padding(padding: AppSpacing.verticalXs4, child: this);

  /// 8px vertical padding
  Widget get paddingVertical8 => Padding(padding: AppSpacing.verticalSm8, child: this);

  /// 12px vertical padding
  Widget get paddingVertical12 => Padding(padding: AppSpacing.verticalMd12, child: this);

  /// 16px vertical padding
  Widget get paddingVertical16 => Padding(padding: AppSpacing.verticalMd16, child: this);

  /// 24px vertical padding
  Widget get paddingVertical24 => Padding(padding: AppSpacing.verticalLg24, child: this);

  // ─────────────────────────────────────────────────────────────────────
  // SINGLE SIDE (using AppSpacing values)
  // ─────────────────────────────────────────────────────────────────────

  /// Custom padding on specific sides using AppSpacing values.
  ///
  /// Example: `Text('Hello').paddingOnly(l: AppSpacing.md16, t: AppSpacing.sm8)`
  Widget paddingOnly({double l = 0, double t = 0, double r = 0, double b = 0}) => Padding(
        padding: EdgeInsets.only(left: l, top: t, right: r, bottom: b),
        child: this,
      );

  /// Custom EdgeInsets padding.
  ///
  /// Example: `Text('Hello').padding(AppSpacing.allMd16)`
  Widget padding(EdgeInsetsGeometry insets) => Padding(padding: insets, child: this);
}
