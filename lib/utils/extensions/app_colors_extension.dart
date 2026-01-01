import 'package:flutter/material.dart';

/// A [ThemeExtension] that defines custom colors for the app.
///
/// This allows us to define colors that are not part of the standard [ColorScheme]
/// (like shimmer colors) and have them automatically switch between light and dark modes
/// with proper interpolation.
///
/// ## Usage
/// ```dart
/// final appColors = Theme.of(context).extension<AppColors>()!;
/// // or using context extension:
/// final appColors = context.appColors;
///
/// Container(color: appColors.shimmerBgColor);
/// ```
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.shimmerColor,
    required this.shimmerBgColor,
    // 1. Add your new color here:
    // required this.brandPink,
  });

  /// The color of the shimmering effect itself.
  final Color shimmerColor;

  /// The background color behind the shimmer.
  final Color shimmerBgColor;

  // 2. Define the property:
  // final Color brandPink;

  @override
  AppColors copyWith({
    Color? shimmerColor,
    Color? shimmerBgColor,
    // 3. Add to copyWith:
    // Color? brandPink,
  }) {
    return AppColors(
      shimmerColor: shimmerColor ?? this.shimmerColor,
      shimmerBgColor: shimmerBgColor ?? this.shimmerBgColor,
      // brandPink: brandPink ?? this.brandPink,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      shimmerColor: Color.lerp(shimmerColor, other.shimmerColor, t)!,
      shimmerBgColor: Color.lerp(shimmerBgColor, other.shimmerBgColor, t)!,
      // 4. Add to lerp (animation):
      // brandPink: Color.lerp(brandPink, other.brandPink, t)!,
    );
  }
}
