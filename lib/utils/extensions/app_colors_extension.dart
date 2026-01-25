import 'package:flutter/material.dart';

/// Color constants for the app
class AppColorConstants {
  static const Color bottomNavbarColor = Color(0xffF1FCFD);
  static const Color pink = Color(0xffEA7085);
  static const Color coreTextColor = Color(0xff464646);
  static const Color shimmerColor = Color(0xFFE0E0E0);
  static const Color shimmerBgColor = Color(0xFFF5F5F5);
  static const Color success = Color(0xFF4CAF50);
}

/// A [ThemeExtension] that defines custom colors for the app.
///
/// This allows us to define colors that are not part of the standard [ColorScheme]
/// (like shimmer colors) and have them automatically switch between light and dark modes
/// with proper interpolation.
///
/// ## Usage
/// ```dart
/// final appColors = Theme.of(context).extension<AppColors>()!;
/// or using context extension:
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
    required this.bottomNavbarColor,
    required this.bottomNavbarSelectedColor,
    required this.pink,
    required this.coreTextColor,
    required this.black400,
    required this.deemphasizedText,
  });

  /// The color of the shimmering effect itself.
  final Color shimmerColor;

  /// The background color behind the shimmer.
  final Color shimmerBgColor;

  /// Semantic success color.
  final Color success;
  
  /// Bottom navigation bar background color.
  final Color bottomNavbarColor;

  /// Bottom navigation bar selected background color.
  final Color bottomNavbarSelectedColor;
  
  /// Primary pink/accent color.
  final Color pink;
  
  /// Core text color for the app.
  final Color coreTextColor;
  
  /// black 400 text color  
  final Color black400;

  /// deemphasizedText color
  final Color deemphasizedText;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? shimmerColor,
    Color? shimmerBgColor,
    Color? success,
    Color? bottomNavbarColor,
    Color? pink,
    Color? coreTextColor,
    Color? bottomNavbarSelectedColor,
    Color? black400,
    Color? deemphasizedText,
  }) {
    return AppColors(
      shimmerColor: shimmerColor ?? this.shimmerColor,
      shimmerBgColor: shimmerBgColor ?? this.shimmerBgColor,
      success: success ?? this.success,
      bottomNavbarColor: bottomNavbarColor ?? this.bottomNavbarColor,
      bottomNavbarSelectedColor:  bottomNavbarSelectedColor ?? this.bottomNavbarSelectedColor,
      pink: pink ?? this.pink,
      coreTextColor: coreTextColor ?? this.coreTextColor,
      black400: black400 ?? this.black400,    
      deemphasizedText: deemphasizedText ?? this.deemphasizedText,
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
      bottomNavbarColor: Color.lerp(bottomNavbarColor, other.bottomNavbarColor, t)!,
      bottomNavbarSelectedColor: Color.lerp(bottomNavbarSelectedColor, other.bottomNavbarSelectedColor, t)!,
      pink: Color.lerp(pink, other.pink, t)!,
      coreTextColor: Color.lerp(coreTextColor, other.coreTextColor, t)!,
      black400: Color.lerp(black400, other.black400, t)!,
      deemphasizedText: Color.lerp(deemphasizedText, other.deemphasizedText, t)!,
    );
  }
}
