import 'package:flutter/material.dart';

/// Extension on [BuildContext] for easy access to theme properties.
///
/// This follows Flutter industry best practices by providing concise
/// access to [ThemeData], [TextTheme], and [ColorScheme].
///
/// ## Text Style Usage
/// ```dart
/// Instead of:
/// Text('Hello', style: Theme.of(context).textTheme.bodyMedium)
///
/// You can write:
/// Text('Hello', style: context.bodyMedium14())
///
/// With overrides:
/// Text('Hello', style: context.bodyMedium14(
///   color: context.colorScheme.error,
///   fontWeight: FontWeight.bold,
/// ))
/// ```
///
/// ## Color Usage
/// ```dart
/// color: Theme.of(context).colorScheme.primary
///
/// You can write:
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
