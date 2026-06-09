import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter/utils/utils.dart';

/// Provides [ThemeData] builders for light and dark themes.
///
/// **Important**: Don't make colors public
/// Always access through [Theme] using [BuildContext]
///
/// Example Usage:
///
/// ```dart
/// color: Theme.of(context).colorScheme.primary
/// color: context.colorScheme.primary - this method is using the extensions
/// ```
class ThemeService {
  ThemeService({required this.isDark});

  final bool isDark;

  // Brand Colors
  final Color _primaryColor = const Color(0xFF127592);
  final Color _secondaryColor = const Color(0xFF7FD0D3);
  final Color _tertiaryColor = const Color(0xFFFFCB4D);
  final Color _pinkColor = const Color(0xffEA7085);

  // Surface & Background
  final Color _lightSurfaceColor = const Color(0xFFB8B8FF);
  final Color _darkSurfaceColor = const Color(0xFF023047);
  final Color _lightBackgroundColor = const Color(0xFFF7F7F7);
  final Color _darkBackgroundColor = const Color(0xFF000000);
  
  // Shadows
  final Color _lightShadowColor = const Color(0xFFE2E8F0);
  final Color _darkShadowColor = const Color(0xFF0D1117);

  // Semantic
  final Color _errorColor = const Color(0XFFD32F2F);
  final Color _errorDarkColor = const Color(0XFFEF9A9A);
  
  // UI Elements
  final Color _outlineColor = const Color(0xFF90A4AE);
  final Color _bottomNavbarColor = const Color(0xffF1FCFD);
  final Color _bottomNavbarDarkColor = const Color(0xFF1A1A1A);
  
  // Text Colors
  final Color _coreTextColor = const Color(0xff464646);

  // Input Borders
  final Color _inputBorderEnabledColor = const Color(0xffC6DEE0);

  Color get shimmersColor => isDark ? const Color(0xFF263238) : const Color(0xFFE0E0E0);
  Color get shimmersBgColor => isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5);

  ThemeData lightThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: _lightBackgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        primary: _primaryColor,
        onPrimary: Colors.white,
        secondary: _secondaryColor,
        onSecondary: Colors.white,
        tertiary: _tertiaryColor,
        onTertiary: Colors.white,
        surface: _lightSurfaceColor,
        onSurface: _darkBackgroundColor,
        shadow: _lightShadowColor,
        outline: _outlineColor,
        error: _errorColor,
      ),
      textTheme: AppTypography.textTheme(_coreTextColor),
      fontFamily: AppTypography.fontFamily,
      elevatedButtonTheme: _elevatedButtonThemeData(),
      outlinedButtonTheme: _outlinedButtonThemeData(),
      textButtonTheme: _textButtonThemeData(),
      inputDecorationTheme: _inputDecorationTheme(),
      appBarTheme: _appBarTheme(),
      iconTheme: _iconThemeData(),
      bottomNavigationBarTheme: _bottomNavigationBarThemeData(),
      tabBarTheme: TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade400,
      ),
    );
  }

  ThemeData darkThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: _darkBackgroundColor,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: _primaryColor,
        primary: _primaryColor,
        onPrimary: Colors.white,
        secondary: _secondaryColor,
        onSecondary: Colors.white,
        tertiary: _tertiaryColor,
        onTertiary: Colors.white,
        surface: _darkSurfaceColor,
        onSurface: _lightBackgroundColor,
        shadow: _darkShadowColor,
        outline: _outlineColor,
        error: _errorDarkColor,
      ),
      textTheme: AppTypography.textTheme(_coreTextColor),
      fontFamily: AppTypography.fontFamily,
      elevatedButtonTheme: _elevatedButtonThemeData(),
      outlinedButtonTheme: _outlinedButtonThemeData(),
      textButtonTheme: _textButtonThemeData(),
      inputDecorationTheme: _inputDecorationTheme(),
      appBarTheme: _appBarTheme(),
      iconTheme: _iconThemeData(),
      bottomNavigationBarTheme: _bottomNavigationBarThemeData(),
      tabBarTheme: TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade400,
      ),
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: _primaryColor,
        elevation: 0,
        textStyle: GoogleFonts.platypi(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isDark ? _darkBackgroundColor : Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.medium12,
        ),
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }

  OutlinedButtonThemeData _outlinedButtonThemeData() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryColor,
        backgroundColor: isDark ? _darkSurfaceColor : _lightSurfaceColor,
        elevation: 0,
        side: BorderSide(
          color: _primaryColor,
        ),
        textStyle: GoogleFonts.notoSans(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: _primaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.large16,
        ),
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }

  TextButtonThemeData _textButtonThemeData() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryColor,
        elevation: 0,
        textStyle: GoogleFonts.platypi(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: _primaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.medium12,
        ),
        maximumSize: const Size(double.infinity, 48),
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xff262D2E),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: _inputBorderEnabledColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: _inputBorderEnabledColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xff262D2E),
        ),
      ),
      filled: true,
      fillColor: isDark ? _darkSurfaceColor : Colors.white,
      hintStyle: GoogleFonts.notoSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.286,
        color: isDark ? _lightBackgroundColor : _coreTextColor,
      ),
      labelStyle: const TextStyle(color: Colors.white),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      foregroundColor: isDark ? _lightBackgroundColor : _darkBackgroundColor,
      backgroundColor: isDark ? _darkSurfaceColor : _primaryColor,
      centerTitle: Platform.isIOS,
      iconTheme: IconThemeData(
        color: isDark ? _lightBackgroundColor : _lightBackgroundColor,
      ),
      titleTextStyle: GoogleFonts.platypi(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: isDark ? _lightBackgroundColor : _lightBackgroundColor,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
    );
  }

  IconThemeData _iconThemeData() {
    return IconThemeData(
      color: isDark ? _lightBackgroundColor : _darkBackgroundColor,
    );
  }

  BottomNavigationBarThemeData _bottomNavigationBarThemeData() {
    return BottomNavigationBarThemeData(
      backgroundColor: isDark ? _bottomNavbarDarkColor : _bottomNavbarColor,
      type: BottomNavigationBarType.fixed,
      elevation: 16,
      selectedItemColor: _pinkColor,
      unselectedItemColor: isDark ? _lightBackgroundColor : const Color(0xff969696),
      showUnselectedLabels: true,
    );
  }

  static void setSystemUIOverlayStyle({bool isDark = false}) {
    if (isDark) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    }
  }
}
