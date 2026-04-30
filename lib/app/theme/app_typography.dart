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

class AppTypography {
  // Private constant for the default text color used in body styles
  static TextTheme textTheme(Color textColor) {
    return TextTheme(
      // Display - Hero text, very large
      displayLarge: GoogleFonts.platypi(
        fontSize: FontSize.display1.size,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: GoogleFonts.platypi(
        fontSize: FontSize.display2.size,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: GoogleFonts.platypi(
        fontSize: FontSize.xxxl.size,
        fontWeight: FontWeight.w700,
      ),

      // Headline - Section headers
      headlineLarge: GoogleFonts.platypi(
        fontSize: FontSize.xxxl.size,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.platypi(
        fontSize: FontSize.xl.size,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.platypi(
        fontSize: FontSize.lg.size,
        fontWeight: FontWeight.w600,
      ),

      // Title - Component titles, app bars
      titleLarge: GoogleFonts.platypi(
        fontSize: FontSize.lg.size,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.platypi(
        fontSize: FontSize.md.size,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.platypi(
        fontSize: FontSize.s.size,
        fontWeight: FontWeight.w600,
      ),

      // Body - Main content
      bodyLarge: GoogleFonts.notoSans(
        fontSize: FontSize.md.size,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.25,
      ),
      bodyMedium: GoogleFonts.notoSans(
        fontSize: FontSize.s.size,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.714,
      ),
      bodySmall: GoogleFonts.notoSans(
        fontSize: FontSize.xs.size,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: 1,
      ),

      // Label - Buttons, tabs
      labelLarge: GoogleFonts.notoSans(
        fontSize: FontSize.md.size,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.notoSans(
        fontSize: FontSize.s.size,
        fontWeight: FontWeight.w600,
        height: 1.714,
      ),
      labelSmall: GoogleFonts.notoSans(
        fontSize: FontSize.xs.size,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static String? get fontFamily => GoogleFonts.notoSans().fontFamily;
}
