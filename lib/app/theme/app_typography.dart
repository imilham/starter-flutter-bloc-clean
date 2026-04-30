import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Standardized font size scale for the application.
///
/// Provides a single source of truth for typography sizes so changes
/// to the design scale propagate everywhere automatically.
///
/// Example:
/// ```dart
/// fontSize: FontSize.md.size // 16
/// ```
enum FontSize {
  /// Display 1 - 32px (hero text)
  display1(32),

  /// Display 2 - 28px
  display2(28),

  /// Display 3 / xxxl - 24px (large section headers)
  xxxl(24),

  /// Extra extra large - 22px (page titles)
  xxl(22),

  /// Extra large - 20px (section headers)
  xl(20),

  /// Large - 18px (sub-headers)
  lg(18),

  /// Medium - 16px (default body text)
  md(16),

  /// Small - 14px (secondary text, buttons)
  s(14),

  /// Extra small - 12px (captions, hints)
  xs(12),

  /// Extra extra small - 10px (micro text, badges)
  xxs(10);

  const FontSize(this.size);

  /// Numeric font size in logical pixels.
  final double size;
}

/// Font families used throughout the application.
///
/// Centralizing font references here means swapping a font is a one-line
/// change, and adding a 3rd font later is just one new case.
///
/// Example:
/// ```dart
/// FontFamily.heading.style(fontSize: FontSize.xl.size, fontWeight: FontWeight.w700)
/// ```
enum FontFamily {
  /// Display/heading font — hero text, headlines, titles, app bars.
  heading,

  /// Body/UI font — body text, buttons, labels, form hints.
  body,
}

extension FontFamilyExtension on FontFamily {
  /// Resolves this enum case to a [TextStyle] from Google Fonts.
  TextStyle style({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) {
    switch (this) {
      case FontFamily.heading:
        return GoogleFonts.platypi(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: height,
        );
      case FontFamily.body:
        return GoogleFonts.notoSans(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: height,
        );
    }
  }

  /// The resolved font family name string — useful for [ThemeData.fontFamily].
  String? get familyName {
    switch (this) {
      case FontFamily.heading:
        return GoogleFonts.platypi().fontFamily;
      case FontFamily.body:
        return GoogleFonts.notoSans().fontFamily;
    }
  }
}

class AppTypography {
  // Private constant for the default text color used in body styles
  static TextTheme textTheme(Color textColor) {
    return TextTheme(
      // Display - Hero text, very large
      displayLarge: FontFamily.heading.style(
        fontSize: FontSize.display1.size,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: FontFamily.heading.style(
        fontSize: FontSize.display2.size,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: FontFamily.heading.style(
        fontSize: FontSize.xxxl.size,
        fontWeight: FontWeight.w700,
      ),

      // Headline - Section headers
      headlineLarge: FontFamily.heading.style(
        fontSize: FontSize.xxxl.size,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: FontFamily.heading.style(
        fontSize: FontSize.xl.size,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: FontFamily.heading.style(
        fontSize: FontSize.lg.size,
        fontWeight: FontWeight.w600,
      ),

      // Title - Component titles, app bars
      titleLarge: FontFamily.heading.style(
        fontSize: FontSize.lg.size,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: FontFamily.heading.style(
        fontSize: FontSize.md.size,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: FontFamily.heading.style(
        fontSize: FontSize.s.size,
        fontWeight: FontWeight.w600,
      ),

      // Body - Main content
      bodyLarge: FontFamily.body.style(
        fontSize: FontSize.md.size,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.25,
      ),
      bodyMedium: FontFamily.body.style(
        fontSize: FontSize.s.size,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.714,
      ),
      bodySmall: FontFamily.body.style(
        fontSize: FontSize.xs.size,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: 1,
      ),

      // Label - Buttons, tabs
      labelLarge: FontFamily.body.style(
        fontSize: FontSize.md.size,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: FontFamily.body.style(
        fontSize: FontSize.s.size,
        fontWeight: FontWeight.w600,
        height: 1.714,
      ),
      labelSmall: FontFamily.body.style(
        fontSize: FontSize.xs.size,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static String? get fontFamily => FontFamily.body.familyName;
}
