import 'package:flutter/material.dart';

class AppColorConstants {
  // Brand Colors
  static const Color primary = Color(0xFF127592);
  static const Color secondary = Color(0xFF7FD0D3);
  static const Color tertiary = Color(0xFFFFCB4D);
  static const Color pink = Color(0xffEA7085);

  // Surface & Background
  static const Color lightSurface = Color(0xFFB8B8FF);
  static const Color darkSurface = Color(0xFF023047);
  static const Color lightBackground = Color(0xFFF7F7F7);
  static const Color darkBackground = Color(0xFF000000);
  
  // Shadows
  static const Color lightShadow = Color(0xFFE2E8F0);
  static const Color darkShadow = Color(0xFF0D1117);

  // Semantic
  static const Color error = Color(0XFFD32F2F);
  static const Color errorDark = Color(0XFFEF9A9A);
  static const Color success = Color(0xFF4CAF50); // Kept existing, check if theme differs
  static const Color successLight = Color(0xFF2E7D32);
  static const Color successDark = Color(0xFF81C784);
  
  // UI Elements
  static const Color outline = Color(0xFF90A4AE);
  static const Color bottomNavbar = Color(0xffF1FCFD); // Light mode default
  static const Color bottomNavbarDark = Color(0xFF1A1A1A);
  static const Color bottomNavbarSelected = Color(0xffFBE5E9);
  
  // Text Colors
  static const Color coreText = Color(0xff464646);
  static const Color black400 = Color(0xff969696);
  static const Color deemphasizedText = Color(0xff878787);

  // Input Borders
  static const Color inputBorder = Color(0xff262D2E);
  static const Color inputBorderEnabled = Color(0xffC6DEE0);

  // Shimmer
  static const Color shimmerLight = Color(0xFFE0E0E0); // Kept existing
  static const Color shimmerBgLight = Color(0xFFF5F5F5); // Kept existing
  static const Color shimmerDark = Color(0xFF263238); // Used as bg in dark theme
  
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
    required this.themeLerpColor,
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

  /// A specific color for demonstrating lerp
  final Color themeLerpColor;

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
    Color? themeLerpColor,
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
      themeLerpColor: themeLerpColor ?? this.themeLerpColor,
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
      themeLerpColor: Color.lerp(themeLerpColor, other.themeLerpColor, t)!,
    );
  }
}
