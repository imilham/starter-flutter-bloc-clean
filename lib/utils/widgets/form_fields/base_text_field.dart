// ignore_for_file: comment_references

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The foundational text field widget following Atomic Design principles.
///
/// This is the **Atom** — the smallest, most basic form input component.
/// All specialized text fields (Password, Stepper, Description) are built
/// on top of this base widget using composition.
///
/// ## Design Philosophy
/// - **Single Responsibility**: Only handles core text input styling
/// - **Theme-Aware**: Uses [InputDecorationTheme] for consistent styling
/// - **Composable**: Specialized fields wrap this widget, not extend it
///
/// ## Example Usage
/// ```dart
/// CommonBaseTextField(
///   controller: _emailController,
///   hintText: 'Enter email',
///   title: 'Email Address',
///   keyboardType: TextInputType.emailAddress,
///   validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
/// )
/// ```
///
/// For specialized inputs, use:
/// - PasswordFormField for password inputs with visibility toggle
/// - StepperFormField for numeric inputs with increment/decrement
/// - DescriptionFormField for multi-line text areas
class CommonBaseTextField extends StatelessWidget {
  /// Creates a base text field.
  ///
  /// Throws [AssertionError] if [obscureText] is true and [maxLines] is not 1.
  const CommonBaseTextField({
    required this.controller,
    required this.hintText,
    super.key,
    this.title,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
  }) : assert(
          !obscureText || maxLines == 1,
          'Obscured text fields must have maxLines = 1',
        );

  /// Controller for the text field value.
  final TextEditingController controller;

  /// Hint text displayed when the field is empty.
  final String hintText;

  /// Optional label displayed above the text field.
  final String? title;

  /// Widget displayed at the end of the text field.
  final Widget? suffixIcon;

  /// Widget displayed at the start of the text field.
  final Widget? prefixIcon;

  /// Whether to obscure the text (for passwords).
  final bool obscureText;

  /// The type of keyboard to display.
  final TextInputType? keyboardType;

  /// The action button on the keyboard.
  final TextInputAction? textInputAction;

  /// Input formatters to apply.
  final List<TextInputFormatter>? inputFormatters;

  /// Validation function.
  final String? Function(String?)? validator;

  /// Callback when text changes.
  final void Function(String)? onChanged;

  /// Callback when field is tapped.
  final VoidCallback? onTap;

  /// Callback when editing is complete.
  final VoidCallback? onEditingComplete;

  /// Callback when user submits (presses done/next on keyboard).
  ///
  /// Useful for navigating to the next field in a form.
  final void Function(String)? onFieldSubmitted;

  /// When to validate automatically.
  final AutovalidateMode autovalidateMode;

  /// Maximum number of lines.
  final int? maxLines;

  /// Minimum number of lines.
  final int? minLines;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Whether the field is enabled.
  final bool enabled;

  /// Focus node for keyboard focus control.
  final FocusNode? focusNode;

  /// Whether to autofocus this field.
  final bool autofocus;

  /// Text capitalization mode.
  final TextCapitalization textCapitalization;

  /// Custom content padding.
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title label
        if (title != null) _buildTitle(theme),

        // Text field
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          validator: validator,
          onChanged: onChanged,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          autovalidateMode: autovalidateMode,
          maxLines: obscureText ? 1 : maxLines,
          minLines: minLines,
          readOnly: readOnly,
          enabled: enabled,
          focusNode: focusNode,
          autofocus: autofocus,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  /// Builds the title label widget.
  Widget _buildTitle(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title!,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
