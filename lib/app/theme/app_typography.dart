import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  // Private constant for the default text color used in body styles
  static TextTheme textTheme(Color textColor) {
    return TextTheme(
      // Display - Hero text, very large
      displayLarge: GoogleFonts.platypi(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: GoogleFonts.platypi(
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: GoogleFonts.platypi(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),

      // Headline - Section headers
      headlineLarge: GoogleFonts.platypi(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.platypi(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.platypi(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),

      // Title - Component titles, app bars
      titleLarge: GoogleFonts.platypi(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.platypi(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.platypi(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),

      // Body - Main content
      bodyLarge: GoogleFonts.notoSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.25,
      ),
      bodyMedium: GoogleFonts.notoSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.714,
      ),
      bodySmall: GoogleFonts.notoSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: 1,
      ),

      // Label - Buttons, tabs
      labelLarge: GoogleFonts.notoSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.notoSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.714,
      ),
      labelSmall: GoogleFonts.notoSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static String? get fontFamily => GoogleFonts.notoSans().fontFamily;
}
