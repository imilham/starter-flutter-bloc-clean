// ignore_for_file: comment_references

/// Common button components with built-in loading state.
///
/// This library provides themed button widgets that reduce boilerplate
/// by handling loading states, sizing, and icons internally.
///
/// ## Available Buttons
///
/// - [CommonElevatedButton] - Primary filled button for main CTAs
/// - [CommonSecondaryButton] - Outlined button for secondary actions
///
/// ## Size Variants
///
/// Use [ButtonSize] enum or factory constructors:
/// ```dart
/// Using enum
/// CommonElevatedButton(
///   text: 'Save',
///   size: ButtonSize.small,
///   onPressed: () {},
/// )
///
/// Using factory
/// CommonElevatedButton.small(
///   text: 'Save',
///   onPressed: () {},
/// )
/// ```
///
/// ## Loading State
///
/// ```dart
/// CommonElevatedButton(
///   text: 'Sign In',
///   isLoading: isAuthLoading,  // Shows spinner when true
///   onPressed: () => login(),
/// )
/// ```
library;

export './button_enums.dart';
export './common_elevated_button.dart';
export './common_outline_button.dart';
