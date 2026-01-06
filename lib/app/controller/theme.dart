import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starter/utils/extensions/app_colors_extension.dart';

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
  final Color _primaryColor = const Color(0xFF9381FF);
  final Color _secondaryColor = const Color(0xFF3A0CA3);
  final Color _lightSurfaceColor = const Color(0xFFB8B8FF);
  final Color _darkSurfaceColor = const Color(0xFF023047);
  final Color _lightBackgroundColor = const Color(0xFFF7F7F7);
  final Color _darkBackgroundColor = const Color(0xFF1B1B1B);
  final Color _lightShadowColor = const Color(0xFFE2E8F0);
  final Color _darkShadowColor = const Color(0xFF0D1117);

  ThemeData _lightThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: _lightBackgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        primary: _primaryColor,
        onPrimary: Colors.white,
        secondary: _secondaryColor,
        onSecondary: Colors.white,
        surface: _lightSurfaceColor,
        onSurface: _darkSurfaceColor,
        shadow: _lightShadowColor,
        outline: const Color(0xFF8D99AE),
        error: const Color(0XFFEF233C),
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
          success: const Color(0xFF22C55E), // Green 500
          exampleColor1: Colors.indigoAccent,
          exampleColor2: Colors.teal,
          exampleColor3: Colors.amber,
          exampleColor4: Colors.deepOrange,
          exampleColor5: Colors.pink,
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
        primary: _primaryColor,
        onPrimary: Colors.white,
        secondary: _secondaryColor,
        onSecondary: Colors.white,
        surface: _darkSurfaceColor,
        onSurface: _lightSurfaceColor,
        shadow: _darkShadowColor,
        outline: const Color(0xFF8D99AE),
        error: const Color(0XFFEF233C),
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
          shimmerColor: const Color(0xff07A8FE).withValues(alpha: 0.24),
          shimmerBgColor: const Color(0xFF3A3A3C),
          success: const Color(0xFF4ADE80), // Green 400
          exampleColor1: Colors.indigoAccent.shade100,
          exampleColor2: Colors.tealAccent,
          exampleColor3: Colors.amberAccent,
          exampleColor4: Colors.deepOrangeAccent,
          exampleColor5: Colors.pinkAccent,
        ),
      ],
    );
  }

  String? _fontFamily() {
    return GoogleFonts.poppins().fontFamily;
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: _primaryColor,
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
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
        foregroundColor: _isDark ? Colors.white : Colors.white,
        backgroundColor: _isDark ? _darkSurfaceColor : _lightSurfaceColor,
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 16,
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
        foregroundColor: _secondaryColor,
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
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
      hintStyle: TextStyle(
        color: _isDark ? Colors.white70 : Colors.black54,
      ),
      labelStyle: TextStyle(
        color: _isDark ? Colors.white : Colors.black87,
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
      titleTextStyle: TextStyle(
        color: _isDark ? _lightBackgroundColor : _darkBackgroundColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
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
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
      ),
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
