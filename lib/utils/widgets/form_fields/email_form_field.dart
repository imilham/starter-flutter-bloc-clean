// ignore_for_file: comment_references

import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

/// A specialized text field for email input with built-in validation.
///
/// This widget uses **Composition** over inheritance, wrapping [CommonBaseTextField]
/// with email-specific functionality.
///
/// ## Features
/// - 📧 Email keyboard type
/// - ✅ Built-in email format validation
/// - 🎨 Theme-aware styling
///
/// ## Example Usage
/// ```dart
/// EmailFormField(
///   controller: _emailController,
///   hintText: 'Enter your email',
///   title: 'Email Address',
/// )
/// ```
///
/// ## Why Separate Widget?
/// Following **Single Responsibility Principle (SRP)**, this widget only handles:
/// 1. Email keyboard type
/// 2. Email format validation
///
/// See also:
/// - [CommonBaseTextField] for the underlying text field.
/// - [PasswordFormField] for password inputs.
class EmailFormField extends StatelessWidget {
  /// Creates an email form field.
  const EmailFormField({
    required this.controller,
    this.hintText,
    super.key,
    this.title,
    this.validator,
    this.onChanged,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.textInputAction,
    this.focusNode,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.enabled = true,
    this.autofocus = false,
  });

  /// Controller for the email value.
  final TextEditingController controller;

  /// Hint text displayed when empty.
  final String? hintText;

  /// Optional label above the field.
  final String? title;

  /// Custom email validation function.
  ///
  /// If null, a default email format validator is used.
  final String? Function(String?)? validator;

  /// Callback when email changes.
  final void Function(String)? onChanged;

  /// When to validate automatically.
  final AutovalidateMode autovalidateMode;

  /// Keyboard action button.
  final TextInputAction? textInputAction;

  /// Focus node for keyboard control.
  final FocusNode? focusNode;

  /// Callback when editing is complete.
  final VoidCallback? onEditingComplete;

  /// Callback when user submits (presses done/next).
  final void Function(String)? onFieldSubmitted;

  /// Whether the field is enabled.
  final bool enabled;

  /// Whether to autofocus this field.
  final bool autofocus;

  /// Default email format validator.
  String? _defaultValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.l10n.errorEnterEmail;
    }

    // Basic email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return context.l10n.errorInvalidEmailAddress;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CommonBaseTextField(
      controller: controller,
      hintText: hintText ?? context.l10n.enterEmailHint,
      title: title,
      validator: validator ?? (value) => _defaultValidator(context, value),
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
      textInputAction: textInputAction ?? TextInputAction.next,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      autofocus: autofocus,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
