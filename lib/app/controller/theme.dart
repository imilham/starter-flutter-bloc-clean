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

  /// **Important**: Don't make colors public
  final Color _primaryColor = const Color(0xFF127592);
  final Color _secondaryColor = const Color(0xFF7FD0D3);
  final Color _tertiaryColor = const Color(0xFFFFCB4D);
  final Color _lightSurfaceColor = const Color(0xFFB8B8FF);
  final Color _darkSurfaceColor = const Color(0xFF023047);
  final Color _lightBackgroundColor = const Color(0xFFF7F7F7);
  final Color _darkBackgroundColor = const Color.fromARGB(255, 0, 0, 0);
  final Color _lightShadowColor = const Color(0xFFE2E8F0);
  final Color _darkShadowColor = const Color(0xFF0D1117);

  /// 
  final Color _bottomNavbarColor = const Color(0xffF1FCFD);
  final Color _pinkColor = const Color(0xffEA7085);
  final Color _coreTextColor = const Color(0xff464646);
  
  ThemeData _lightThemeData() {
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
        outline: const Color(0xFF90A4AE),
        error: const Color(0XFFD32F2F),
      ),
      textTheme: _textTheme(),
      fontFamily: _fontFamily(),
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
          shimmerColor: Colors.grey.shade300,
          shimmerBgColor: Colors.grey.shade100,
          success: const Color(0xFF2E7D32),
          bottomNavbarColor: _bottomNavbarColor,
          bottomNavbarSelectedColor: const Color(0xffFBE5E9),
          pink: _pinkColor,
          coreTextColor: _coreTextColor,  
          black400:const Color(0xff969696),
          deemphasizedText: const Color(0xff878787),
          
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
        tertiary: _tertiaryColor,
        onTertiary: Colors.white,
        surface: _darkSurfaceColor,
        onSurface: const Color(0xFFE0F2F1),
        shadow: _darkShadowColor,
        outline: const Color(0xFF90A4AE),
        error: const Color(0XFFEF9A9A),
      ),
      textTheme: _textTheme(),
      fontFamily: _fontFamily(),
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
          shimmerColor: const Color(0xff80CBC4).withValues(alpha: 0.1),
          shimmerBgColor: const Color(0xFF263238),
          success: const Color(0xFF81C784),
          bottomNavbarColor: const Color(0xFF1A1A1A),
          bottomNavbarSelectedColor: const Color(0xffFBE5E9),
          pink: _pinkColor,
          coreTextColor: Colors.red,
          black400:const Color(0xff969696),  
          deemphasizedText: const Color(0xff878787),
        ),
      ],
    );
  }

  TextTheme _textTheme() {    
    return TextTheme(
      // Display - Hero text, very large
      displayLarge: GoogleFonts.platypi(fontSize: 32, fontWeight: FontWeight.w700,),
      displayMedium: GoogleFonts.platypi(fontSize: 28, fontWeight: FontWeight.w700, ),
      displaySmall: GoogleFonts.platypi(fontSize: 24, fontWeight: FontWeight.w700, ),

      // Headline - Section headers
      headlineLarge: GoogleFonts.platypi(fontSize: 24, fontWeight: FontWeight.w700, ),
      headlineMedium: GoogleFonts.platypi(fontSize: 20, fontWeight: FontWeight.w700, ),
      headlineSmall: GoogleFonts.platypi(fontSize: 18, fontWeight: FontWeight.w700, ),

      // Title - Component titles, app bars
      titleLarge: GoogleFonts.platypi(fontSize: 18, fontWeight: FontWeight.w700, ),
      titleMedium: GoogleFonts.platypi(fontSize: 16, fontWeight: FontWeight.w700, ),
      titleSmall: GoogleFonts.platypi(fontSize: 14, fontWeight: FontWeight.w700, ),

      // Body - Main content
      bodyLarge: GoogleFonts.notoSans(fontSize: 16, fontWeight: FontWeight.w500, color: _coreTextColor, height: 1.25),
      bodyMedium: GoogleFonts.notoSans(fontSize: 14, fontWeight: FontWeight.w500, color: _coreTextColor, height: 1.714, ),
      bodySmall: GoogleFonts.notoSans(fontSize: 12, fontWeight: FontWeight.w900, color: _coreTextColor,  height: 1,),

      // Label - Buttons, tabs
      labelLarge: GoogleFonts.notoSans(fontSize: 16, fontWeight: FontWeight.w700,),
      labelMedium: GoogleFonts.platypi(fontSize: 14, fontWeight: FontWeight.w600, height: 1.714),
      labelSmall: GoogleFonts.notoSans(fontSize: 12, fontWeight: FontWeight.w700,),
    );
  }

  String? _fontFamily() {
    return GoogleFonts.notoSans().fontFamily;
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
          color: _isDark ? _darkBackgroundColor : Colors.white,
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
        backgroundColor: _isDark ? _darkSurfaceColor : _lightSurfaceColor,
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
          color: Color(0xff262D2E), // Default border color
          // width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xffC6DEE0), // Border color when the field is enabled
          // width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xffC6DEE0), // Border color when the field is focused
          // width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red, // Border color when validation fails
          // width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red, // Border color when focused but has an error
          // width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xff262D2E), // Default border color
          // width: 1,
        ),
      ),
      filled: true,
      fillColor: _isDark ? _darkSurfaceColor : Colors.white,
      hintStyle: GoogleFonts.notoSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.286,        
        color: _isDark ? _lightBackgroundColor : _coreTextColor,
      ),
      labelStyle: const TextStyle(color: Colors.white),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      foregroundColor: _isDark ? _lightBackgroundColor : _darkBackgroundColor,
      backgroundColor: _isDark ? _darkSurfaceColor : _primaryColor,
      centerTitle: Platform.isIOS,      
      iconTheme: IconThemeData(
        color: _isDark ? _lightBackgroundColor : _lightBackgroundColor,
      ),
      titleTextStyle: GoogleFonts.platypi(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: _isDark ? _lightBackgroundColor : _lightBackgroundColor,
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
      color: _isDark ? _lightBackgroundColor : _darkBackgroundColor,
    );
  }

  BottomNavigationBarThemeData _bottomNavigationBarThemeData() {
    return BottomNavigationBarThemeData(
      backgroundColor: _isDark ?  _bottomNavbarColor : _bottomNavbarColor,
      type: BottomNavigationBarType.fixed,
      elevation: 16,
      selectedItemColor: _pinkColor,
      unselectedItemColor: _isDark ? _lightBackgroundColor : const Color(0xff969696),
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
