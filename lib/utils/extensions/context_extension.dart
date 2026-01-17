import 'package:flutter/material.dart';

/// Extensions on [BuildContext] for navigation, focus, and device query shortcuts.
extension ContextExtension on BuildContext {
  // ─────────────────────────────────────────────────────────────────────
  // NAVIGATION SHORTCUTS
  // ─────────────────────────────────────────────────────────────────────

  /// Default pop to root.
  void popUntilRoot() => Navigator.of(this).popUntil((route) => route.isFirst);

  // ─────────────────────────────────────────────────────────────────────
  // UI & UTILS
  // ─────────────────────────────────────────────────────────────────────

  /// Hides the keyboard by unfocusing.
  void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  /// Hides the keyboard (alias).
  void unfocus() => closeKeyboard();

  // ─────────────────────────────────────────────────────────────────────
  // THEME SHORTCUTS (Complementary to ThemeExtension)
  // ─────────────────────────────────────────────────────────────────────

  /// Returns true if the current brightness is dark.
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Returns the primary color.
  Color get primaryColor => Theme.of(this).colorScheme.primary;

  // ─────────────────────────────────────────────────────────────────────
  // DEVICE TYPE SHORTCUTS
  // ─────────────────────────────────────────────────────────────────────

  /// Returns true if the device width is greater than 600px.
  bool get isTablet => MediaQuery.sizeOf(this).width > 600;
}
