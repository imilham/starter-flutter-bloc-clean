// ignore_for_file: comment_references

import 'package:flutter/material.dart';
import 'package:starter/utils/widgets/form_fields/base_text_field.dart';

/// A specialized text field for password input with visibility toggle.
///
/// This widget uses **Composition** over inheritance, wrapping [CommonBaseTextField]
/// with password-specific functionality.
///
/// ## Features
/// - 🔒 Obscured text by default
/// - 👁️ Visibility toggle button
/// - ✅ Built-in password validation option
/// - 🎨 Theme-aware icon colors
///
/// ## Example Usage
/// ```dart
/// PasswordFormField(
///   controller: _passwordController,
///   hintText: 'Enter your password',
///   title: 'Password',
///   validator: (value) {
///     if (value == null || value.length < 8) {
///       return 'Password must be at least 8 characters';
///     }
///     return null;
///   },
/// )
/// ```
///
/// ## Why Separate Widget?
/// Following **Single Responsibility Principle (SRP)**, this widget only handles:
/// 1. Obscuring text
/// 2. Visibility toggle state
///
/// This makes it:
/// - ✅ Easy to unit test
/// - ✅ Easy to modify without breaking other inputs
/// - ✅ Clear API for developers
///
/// See also:
/// - [CommonBaseTextField] for the underlying text field.
/// - [StepperFormField] for numeric inputs with increment/decrement.
class PasswordFormField extends StatefulWidget {
  /// Creates a password form field.
  ///
  /// If [validator] is null, a default validator is used that checks:
  /// - Non-empty input
  /// - Minimum length of [minLength] characters (default: 8)
  const PasswordFormField({
    required this.controller,
    required this.hintText,
    super.key,
    this.title,
    this.validator,
    this.minLength = 8,
    this.onChanged,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.textInputAction,
    this.focusNode,
    this.onEditingComplete,
    this.enabled = true,
  }) : assert(minLength > 0, 'minLength must be positive');

  /// Controller for the password value.
  final TextEditingController controller;

  /// Hint text displayed when empty.
  final String hintText;

  /// Optional label above the field.
  final String? title;

  /// Custom password validation function.
  ///
  /// If null, uses a default validator that checks for non-empty
  /// and minimum [minLength] characters.
  final String? Function(String?)? validator;

  /// Minimum password length for default validation.
  ///
  /// Defaults to 8 characters.
  final int minLength;

  /// Callback when password changes.
  final void Function(String)? onChanged;

  /// When to validate automatically.
  final AutovalidateMode autovalidateMode;

  /// Keyboard action button.
  final TextInputAction? textInputAction;

  /// Focus node for keyboard control.
  final FocusNode? focusNode;

  /// Callback when editing is complete.
  final VoidCallback? onEditingComplete;

  /// Whether the field is enabled.
  final bool enabled;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  /// Tracks whether password is currently visible.
  bool _isVisible = false;

  /// Toggles password visibility.
  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  /// Default validator for password input.
  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < widget.minLength) {
      return 'Password must be at least ${widget.minLength} characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CommonBaseTextField(
      controller: widget.controller,
      hintText: widget.hintText,
      title: widget.title,
      obscureText: !_isVisible,
      validator: widget.validator ?? _defaultValidator,
      onChanged: widget.onChanged,
      autovalidateMode: widget.autovalidateMode,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onEditingComplete: widget.onEditingComplete,
      enabled: widget.enabled,
      keyboardType: TextInputType.visiblePassword,
      suffixIcon: IconButton(
        icon: Icon(
          _isVisible ? Icons.visibility : Icons.visibility_off,
          color: colorScheme.primary,
        ),
        onPressed: _toggleVisibility,
      ),
    );
  }
}

/// Factory extension for creating common password field configurations.
extension PasswordFormFieldFactories on PasswordFormField {
  /// Creates a password field with minimum length validation.
  static PasswordFormField withMinLength({
    required TextEditingController controller,
    int minLength = 8,
    String hintText = 'Enter password',
    String? title,
  }) {
    return PasswordFormField(
      controller: controller,
      hintText: hintText,
      title: title,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        if (value.length < minLength) {
          return 'Password must be at least $minLength characters';
        }
        return null;
      },
    );
  }
}
