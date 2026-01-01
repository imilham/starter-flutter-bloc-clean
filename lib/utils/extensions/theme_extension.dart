import 'package:flutter/material.dart';
import 'package:starter/utils/extensions/app_colors_extension.dart';

/// Extension on [BuildContext] for easy access to theme properties.
///
/// This follows Flutter industry best practices by providing concise
/// access to [ThemeData], [TextTheme], and [ColorScheme].
///
/// ## Text Style Usage
/// ```dart
/// // Instead of:
/// Text('Hello', style: Theme.of(context).textTheme.bodyMedium)
///
/// // You can write:
/// Text('Hello', style: context.bodyMedium)
///
/// // With overrides:
/// Text('Hello', style: context.bodyMedium?.copyWith(
///   color: context.colorScheme.error,
///   fontWeight: FontWeight.bold,
/// ))
/// ```
///
/// ## Color Usage
/// ```dart
/// // Instead of:
/// color: Theme.of(context).colorScheme.primary
///
/// // You can write:
/// color: context.colorScheme.primary
/// ```
///
/// ## Theme-Aware
/// All styles automatically update when the theme changes (light/dark mode).
extension ThemeExtension on BuildContext {
  // ─────────────────────────────────────────────────────────────────────
  // THEME ACCESS
  // ─────────────────────────────────────────────────────────────────────

  /// Access to the current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Access to the current [TextTheme].
  TextTheme get textTheme => theme.textTheme;

  /// Access to the current [ColorScheme].
  ColorScheme get colorScheme => theme.colorScheme;

  /// Access to custom [AppColors].
  AppColors get appColors => theme.extension<AppColors>()!;

  // ─────────────────────────────────────────────────────────────────────
  // DISPLAY STYLES
  // ─────────────────────────────────────────────────────────────────────

  /// Largest display text style.
  TextStyle? get displayLarge => textTheme.displayLarge;

  /// Medium display text style.
  TextStyle? get displayMedium => textTheme.displayMedium;

  /// Smallest display text style.
  TextStyle? get displaySmall => textTheme.displaySmall;

  // ─────────────────────────────────────────────────────────────────────
  // HEADLINE STYLES
  // ─────────────────────────────────────────────────────────────────────

  /// Largest headline text style.
  TextStyle? get headlineLarge => textTheme.headlineLarge;

  /// Medium headline text style.
  TextStyle? get headlineMedium => textTheme.headlineMedium;

  /// Smallest headline text style.
  TextStyle? get headlineSmall => textTheme.headlineSmall;

  // ─────────────────────────────────────────────────────────────────────
  // TITLE STYLES
  // ─────────────────────────────────────────────────────────────────────

  /// Largest title text style.
  TextStyle? get titleLarge => textTheme.titleLarge;

  /// Medium title text style.
  TextStyle? get titleMedium => textTheme.titleMedium;

  /// Smallest title text style.
  TextStyle? get titleSmall => textTheme.titleSmall;

  // ─────────────────────────────────────────────────────────────────────
  // BODY STYLES
  // ─────────────────────────────────────────────────────────────────────

  /// Largest body text style.
  TextStyle? get bodyLarge => textTheme.bodyLarge;

  /// Medium body text style (default for body text).
  TextStyle? get bodyMedium => textTheme.bodyMedium;

  /// Smallest body text style.
  TextStyle? get bodySmall => textTheme.bodySmall;

  // ─────────────────────────────────────────────────────────────────────
  // LABEL STYLES
  // ─────────────────────────────────────────────────────────────────────

  /// Largest label text style.
  TextStyle? get labelLarge => textTheme.labelLarge;

  /// Medium label text style.
  TextStyle? get labelMedium => textTheme.labelMedium;

  /// Smallest label text style.
  TextStyle? get labelSmall => textTheme.labelSmall;

  // ─────────────────────────────────────────────────────────────────────
  // SCREEN SIZE
  // ─────────────────────────────────────────────────────────────────────

  /// Screen size from MediaQuery.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Screen width.
  double get screenWidth => screenSize.width;

  /// Screen height.
  double get screenHeight => screenSize.height;

  /// Screen padding (safe area insets).
  EdgeInsets get screenPadding => MediaQuery.paddingOf(this);

  /// Whether the device is in landscape mode.
  bool get isLandscape => screenWidth > screenHeight;

  /// Whether the device is in portrait mode.
  bool get isPortrait => screenHeight > screenWidth;
}
