import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:starter/utils/extensions/app_colors_extension.dart';
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

  /// **Important**: Don't make colors public
  // Primary: A refined, vibrant Teal
  final Color _primaryColor = const Color(0xFF00796B); // Teal 700 (Rich Teal)
  final Color _lightPrimaryColor = const Color(0xFF009688); // Teal 500 (Vibrant for Light UI)
  final Color _darkPrimaryColor = const Color(0xFF80CBC4); // Teal 200 (Soft for Dark UI)

  // Secondary: Complementary or Deep variant
  final Color _secondaryColor = const Color(0xFF004D40); // Teal 900

  // Light Theme Colors
  final Color _lightSurfaceColor = const Color(0xFFFFFFFF); // Pure White Surface
  final Color _lightBackgroundColor = const Color(0xFFF0F7F6); // Very subtle cool grey/teal tint
  final Color _lightShadowColor = const Color(0xFFB0BEC5); // Blue Grey 200

  // Dark Theme Colors (Avoid "Black")
  final Color _darkSurfaceColor = const Color(0xFF1E2625); // Deep Charcoal/Teal Surface (Material-ish)
  final Color _darkBackgroundColor = const Color(0xFF121515); // Rich Dark, not pure Black
  final Color _darkShadowColor = const Color(0xFF000000);

  ThemeData _lightThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: _lightBackgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        primary: _lightPrimaryColor,
        onPrimary: Colors.white,
        secondary: _secondaryColor,
        onSecondary: Colors.white,
        surface: _lightSurfaceColor,
        onSurface: _darkBackgroundColor, // Dark text on light surface
        shadow: _lightShadowColor,
        outline: const Color(0xFF80CBC4), // Teal 200
        error: const Color(0XFFD32F2F),
      ),
      fontFamily: _fontFamily(),
      elevatedButtonTheme: _elevatedButtonThemeData(),
      outlinedButtonTheme: _outlinedButtonThemeData(),
      textButtonTheme: _textButtonThemeData(),
      inputDecorationTheme: _inputDecorationTheme(),
      appBarTheme: _appBarTheme(),
      iconTheme: _iconThemeData(),
      bottomNavigationBarTheme: _bottomNavigationBarThemeData(),
      extensions: [
        AppColors(
          shimmerColor: Colors.grey.shade300,
          shimmerBgColor: Colors.grey.shade100,
          success: const Color(0xFF2E7D32), // Green 800
          exampleColor: const Color(0xFF673AB7), // Deep Purple (Contrast)
        ),
      ],
    );
  }

  ThemeData _darkThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: _darkBackgroundColor,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: _primaryColor,
        primary: _darkPrimaryColor,
        onPrimary: _darkBackgroundColor, // Dark text on light primary
        secondary: _secondaryColor, // Deep Teal
        onSecondary: Colors.white,
        surface: _darkSurfaceColor,
        onSurface: const Color(0xFFE0F2F1), // Soft White text
        shadow: _darkShadowColor,
        outline: const Color(0xFF4DB6AC), // Teal 300
        error: const Color(0XFFEF9A9A),
      ),
      fontFamily: _fontFamily(),
      elevatedButtonTheme: _elevatedButtonThemeData(),
      outlinedButtonTheme: _outlinedButtonThemeData(),
      textButtonTheme: _textButtonThemeData(),
      inputDecorationTheme: _inputDecorationTheme(),
      appBarTheme: _appBarTheme(),
      iconTheme: _iconThemeData(),
      bottomNavigationBarTheme: _bottomNavigationBarThemeData(),
      extensions: [
        AppColors(
          shimmerColor: const Color(0xff80CBC4).withValues(alpha: 0.1),
          shimmerBgColor: const Color(0xFF263238),
          success: const Color(0xFF81C784), // Green 300
          exampleColor: const Color(0xFFFFD54F), // Amber 300 (Pop)
        ),
      ],
    );
  }

  String? _fontFamily() {
    return appFontFamily;
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // Light: White Text on Teal 500. Dark: Dark Text on Teal 200.
        foregroundColor: _isDark ? _darkBackgroundColor : Colors.white,
        backgroundColor: _isDark ? _darkPrimaryColor : _lightPrimaryColor,
        elevation: 0,
        textStyle: buttonRegular16(
          textColor: _isDark ? _darkBackgroundColor : Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }

  OutlinedButtonThemeData _outlinedButtonThemeData() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        // Light: Teal Text. Dark: Teal Text (Light).
        // Background is Surface.
        foregroundColor: _isDark ? _darkPrimaryColor : _lightPrimaryColor,
        backgroundColor: _isDark ? _darkSurfaceColor : _lightSurfaceColor,
        elevation: 0,
        side: BorderSide(
          color: _isDark ? _darkPrimaryColor : _lightPrimaryColor,
        ),
        textStyle: buttonRegular16(
          textColor: _isDark ? _darkPrimaryColor : _lightPrimaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }

  TextButtonThemeData _textButtonThemeData() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _isDark ? _darkPrimaryColor : _lightPrimaryColor,
        elevation: 0,
        textStyle: buttonSmall14(
          textColor: _isDark ? _darkPrimaryColor : _lightPrimaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        maximumSize: const Size(double.infinity, 48),
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      filled: true,
      fillColor: _isDark ? _darkSurfaceColor : _lightSurfaceColor,
      hintStyle: formHint16(
        textColor: _isDark ? Colors.white70 : Colors.black54,
      ),
      labelStyle: formLabel14(
        textColor: _isDark ? Colors.white : Colors.black87,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      foregroundColor: _isDark ? _lightBackgroundColor : _darkBackgroundColor,
      backgroundColor: _isDark ? _darkSurfaceColor : _lightSurfaceColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: _isDark ? _lightBackgroundColor : _darkBackgroundColor,
      ),
      titleTextStyle: appBar16(
        textColor: _isDark ? _lightBackgroundColor : _darkBackgroundColor,
      ),
    );
  }

  IconThemeData _iconThemeData() {
    return IconThemeData(
      color: _isDark ? _lightBackgroundColor : _darkBackgroundColor,
    );
  }

  BottomNavigationBarThemeData _bottomNavigationBarThemeData() {
    return BottomNavigationBarThemeData(
      backgroundColor: _isDark ? _darkSurfaceColor : _lightSurfaceColor,
      type: BottomNavigationBarType.fixed,
      elevation: 16,
      selectedItemColor: _secondaryColor,
      unselectedItemColor: _isDark ? _lightBackgroundColor : _darkBackgroundColor,
      showUnselectedLabels: true,
      selectedLabelStyle: tab10(fontWeight: FontWeight.bold),
      unselectedLabelStyle: tab10(),
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
