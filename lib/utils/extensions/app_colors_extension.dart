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
    required this.exampleColor1,
    required this.exampleColor2,
    required this.exampleColor3,
    required this.exampleColor4,
    required this.exampleColor5,
  });

  /// The color of the shimmering effect itself.
  final Color shimmerColor;

  /// The background color behind the shimmer.
  final Color shimmerBgColor;

  // TODO(ilham): Remove these example colors later
  final Color exampleColor1;
  final Color exampleColor2;
  final Color exampleColor3;
  final Color exampleColor4;
  final Color exampleColor5;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? shimmerColor,
    Color? shimmerBgColor,
    Color? exampleColor1,
    Color? exampleColor2,
    Color? exampleColor3,
    Color? exampleColor4,
    Color? exampleColor5,
  }) {
    return AppColors(
      shimmerColor: shimmerColor ?? this.shimmerColor,
      shimmerBgColor: shimmerBgColor ?? this.shimmerBgColor,
      exampleColor1: exampleColor1 ?? this.exampleColor1,
      exampleColor2: exampleColor2 ?? this.exampleColor2,
      exampleColor3: exampleColor3 ?? this.exampleColor3,
      exampleColor4: exampleColor4 ?? this.exampleColor4,
      exampleColor5: exampleColor5 ?? this.exampleColor5,
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
      exampleColor1: Color.lerp(exampleColor1, other.exampleColor1, t)!,
      exampleColor2: Color.lerp(exampleColor2, other.exampleColor2, t)!,
      exampleColor3: Color.lerp(exampleColor3, other.exampleColor3, t)!,
      exampleColor4: Color.lerp(exampleColor4, other.exampleColor4, t)!,
      exampleColor5: Color.lerp(exampleColor5, other.exampleColor5, t)!,
    );
  }
}
