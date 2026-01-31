import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starter/utils/utils.dart';

/// A service provider class for managing the theme of the application.
/// This class provides methods to toggle the theme between light and dark,
/// and retrieve the current theme data and mode.
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
class ThemeServiceProvider with ChangeNotifier {
  ThemeServiceProvider({bool isDark = false}) : _isDark = isDark;

  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeData get lightTheme => _lightThemeData();
  ThemeData get darkTheme => _darkThemeData();
  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDark = !_isDark;
    Hive.box<bool>('themeMode').put('isDark', _isDark);
    notifyListeners();
  }

  // todo : remove this
  Color get demoSnapColor => _isDark ? Colors.orangeAccent : Colors.purpleAccent;

  ThemeData _lightThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: AppColorConstants.lightBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColorConstants.primary,
        primary: AppColorConstants.primary,
        onPrimary: Colors.white,
        secondary: AppColorConstants.secondary,
        onSecondary: Colors.white,
        tertiary: AppColorConstants.tertiary,
        onTertiary: Colors.white,
        surface: AppColorConstants.lightSurface,
        onSurface: AppColorConstants.darkBackground,
        shadow: AppColorConstants.lightShadow,
        outline: AppColorConstants.outline,
        error: AppColorConstants.error,
      ),
      textTheme: AppTypography.textTheme(AppColorConstants.coreText),
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
      extensions: const [
        AppColors(
          shimmerColor: AppColorConstants.shimmerLight,
          shimmerBgColor: AppColorConstants.shimmerBgLight,
          success: AppColorConstants.successLight,
          bottomNavbarColor: AppColorConstants.bottomNavbar,
          bottomNavbarSelectedColor: AppColorConstants.bottomNavbarSelected,
          pink: AppColorConstants.pink,
          coreTextColor: AppColorConstants.coreText,
          black400: AppColorConstants.black400,
          deemphasizedText: AppColorConstants.deemphasizedText,
          themeLerpColor: Colors.purpleAccent,
        ),
      ],
    );
  }

  ThemeData _darkThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: AppColorConstants.darkBackground,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColorConstants.primary,
        primary: AppColorConstants.primary,
        onPrimary: Colors.white,
        secondary: AppColorConstants.secondary,
        onSecondary: Colors.white,
        tertiary: AppColorConstants.tertiary,
        onTertiary: Colors.white,
        surface: AppColorConstants.darkSurface,
        onSurface: AppColorConstants.lightBackground,
        shadow: AppColorConstants.darkShadow,
        outline: AppColorConstants.outline,
        error: AppColorConstants.errorDark,
      ),
      textTheme: AppTypography.textTheme(AppColorConstants.coreText),
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
      extensions: [
        AppColors(
          shimmerColor: AppColorConstants.shimmerDark.withValues(alpha: 0.1),
          shimmerBgColor: AppColorConstants.shimmerDark,
          success: AppColorConstants.successDark,
          bottomNavbarColor: AppColorConstants.bottomNavbarDark,
          bottomNavbarSelectedColor: AppColorConstants.bottomNavbarSelected,
          pink: AppColorConstants.pink,
          coreTextColor: Colors.red,
          black400: AppColorConstants.black400,
          deemphasizedText: AppColorConstants.deemphasizedText,
          themeLerpColor: Colors.orangeAccent,
        ),
      ],
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColorConstants.primary,
        elevation: 0,
        textStyle: GoogleFonts.platypi(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: _isDark ? AppColorConstants.darkBackground : Colors.white,
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
        foregroundColor: AppColorConstants.primary,
        backgroundColor: _isDark ? AppColorConstants.darkSurface : AppColorConstants.lightSurface,
        elevation: 0,
        side: const BorderSide(
          color: AppColorConstants.primary,
        ),
        textStyle: GoogleFonts.notoSans(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColorConstants.primary,
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
        foregroundColor: AppColorConstants.primary,
        elevation: 0,
        textStyle: GoogleFonts.platypi(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColorConstants.primary,
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
        borderSide: const BorderSide(
          color: AppColorConstants.inputBorderEnabled,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColorConstants.inputBorderEnabled,
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
      fillColor: _isDark ? AppColorConstants.darkSurface : Colors.white,
      hintStyle: GoogleFonts.notoSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.286,
        color: _isDark ? AppColorConstants.lightBackground : AppColorConstants.coreText,
      ),
      labelStyle: const TextStyle(color: Colors.white),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      foregroundColor: _isDark ? AppColorConstants.lightBackground : AppColorConstants.darkBackground,
      backgroundColor: _isDark ? AppColorConstants.darkSurface : AppColorConstants.primary,
      centerTitle: Platform.isIOS,
      iconTheme: IconThemeData(
        color: _isDark ? AppColorConstants.lightBackground : AppColorConstants.lightBackground,
      ),
      titleTextStyle: GoogleFonts.platypi(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: _isDark ? AppColorConstants.lightBackground : AppColorConstants.lightBackground,
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
      color: _isDark ? AppColorConstants.lightBackground : AppColorConstants.darkBackground,
    );
  }

  BottomNavigationBarThemeData _bottomNavigationBarThemeData() {
    return BottomNavigationBarThemeData(
      backgroundColor: _isDark ? AppColorConstants.bottomNavbarDark : AppColorConstants.bottomNavbar,
      type: BottomNavigationBarType.fixed,
      elevation: 16,
      selectedItemColor: AppColorConstants.pink,
      unselectedItemColor: _isDark ? AppColorConstants.lightBackground : const Color(0xff969696),
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
