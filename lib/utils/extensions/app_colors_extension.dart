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
    required this.success,
  });

  /// The color of the shimmering effect itself.
  final Color shimmerColor;

  /// The background color behind the shimmer.
  final Color shimmerBgColor;

  /// Semantic success color.
  final Color success;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? shimmerColor,
    Color? shimmerBgColor,
    Color? success,
  }) {
    return AppColors(
      shimmerColor: shimmerColor ?? this.shimmerColor,
      shimmerBgColor: shimmerBgColor ?? this.shimmerBgColor,
      success: success ?? this.success,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      shimmerColor: Color.lerp(shimmerColor, other.shimmerColor, t)!,
      shimmerBgColor: Color.lerp(shimmerBgColor, other.shimmerBgColor, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}
