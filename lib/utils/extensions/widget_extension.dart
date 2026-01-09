import 'package:flutter/widgets.dart';
import 'package:starter/utils/constants/radius.dart';
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

/// Extension to provide convenient border radius (clipping) methods on widgets.
///
/// Usage:
/// ```dart
/// Container().borderRadiusAll8
/// Container().borderRadiusTop16
/// Container().borderRadiusOnly(tl: 8, br: 8)
/// ```
extension WidgetBorderRadiusExtension on Widget {
  // ─────────────────────────────────────────────────────────────────────
  // ALL CORNERS
  // ─────────────────────────────────────────────────────────────────────

  /// 4px radius on all corners
  Widget get borderRadiusAll4 => ClipRRect(borderRadius: AppRadius.extraSmall4, child: this);

  /// 8px radius on all corners
  Widget get borderRadiusAll8 => ClipRRect(borderRadius: AppRadius.small8, child: this);

  /// 12px radius on all corners
  Widget get borderRadiusAll12 => ClipRRect(borderRadius: AppRadius.medium12, child: this);

  /// 16px radius on all corners
  Widget get borderRadiusAll16 => ClipRRect(borderRadius: AppRadius.large16, child: this);

  /// 24px radius on all corners
  Widget get borderRadiusAll24 => ClipRRect(borderRadius: AppRadius.extraLarge24, child: this);

  /// Pill radius (999px) on all corners
  Widget get borderRadiusAllPill => ClipRRect(borderRadius: AppRadius.pill999, child: this);

  // ─────────────────────────────────────────────────────────────────────
  // TOP CORNERS
  // ─────────────────────────────────────────────────────────────────────

  /// 8px radius on top corners
  Widget get borderRadiusTop8 => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.sm8)),
        child: this,
      );

  /// 16px radius on top corners
  Widget get borderRadiusTop16 => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg16)),
        child: this,
      );

  // ─────────────────────────────────────────────────────────────────────
  // BOTTOM CORNERS
  // ─────────────────────────────────────────────────────────────────────

  /// 8px radius on bottom corners
  Widget get borderRadiusBottom8 => ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppRadius.sm8)),
        child: this,
      );

  /// 16px radius on bottom corners
  Widget get borderRadiusBottom16 => ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppRadius.lg16)),
        child: this,
      );

  // ─────────────────────────────────────────────────────────────────────
  // CUSTOM CORNERS
  // ─────────────────────────────────────────────────────────────────────

  /// Custom radius on specific corners.
  ///
  /// Example: `Container().borderRadiusOnly(tl: 8, br: 8)`
  Widget borderRadiusOnly({double tl = 0, double tr = 0, double bl = 0, double br = 0}) => ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(tl),
          topRight: Radius.circular(tr),
          bottomLeft: Radius.circular(bl),
          bottomRight: Radius.circular(br),
        ),
        child: this,
      );

  // ─────────────────────────────────────────────────────────────────────
  // OVAL / CIRCLE
  // ─────────────────────────────────────────────────────────────────────

  /// Clips the widget into an oval (or circle if the widget is square).
  Widget get clipOval => ClipOval(child: this);

  /// Clips the widget with a custom border radius.
  Widget clipRRect(BorderRadius borderRadius) => ClipRRect(borderRadius: borderRadius, child: this);
}
