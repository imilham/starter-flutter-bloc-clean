import 'package:flutter/material.dart';
import 'package:starter/app/app.dart';

import 'package:starter/l10n/gen/app_localizations.dart';

/// A utility class for showing common dialogs.
///
/// ## Usage
/// ```dart
/// Confirmation dialog
/// final confirmed = await CommonDialog.confirm(
///   context,
///   title: 'Delete Item',
///   message: 'Are you sure you want to delete this item?',
/// );
///
/// Alert dialog
/// await CommonDialog.alert(
///   context,
///   title: 'Error',
///   message: 'Something went wrong.',
/// );
/// ```
class CommonDialog {
  CommonDialog._();

  /// Shows a confirmation dialog with Yes/No buttons.
  ///
  /// Returns `true` if confirmed, `false` if cancelled.
  ///
  /// [confirmColor] defaults to [Colors.blue]. Ignored if [isDangerous] is true.
  /// [cancelColor] defaults to [Colors.grey].
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    bool isDangerous = false,
    Color confirmColor = Colors.red,
    Color cancelColor = Colors.blue,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(foregroundColor: cancelColor),
            child: Text(cancelText ?? AppLocalizations.of(context)!.no),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: isDangerous ? context.colorScheme.error : confirmColor,
            ),
            child: Text(confirmText ?? AppLocalizations.of(context)!.yes),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Shows a simple alert dialog with an OK button.
  ///
  /// The dialog is not dismissible by tapping outside - user must tap the button.
  /// Colors automatically adapt to the current theme (light/dark mode).
  ///
  /// [buttonColor] defaults to [Colors.blue]. Pass a custom color to override.
  static Future<void> alert(
    BuildContext context, {
    required String title,
    required String message,
    String? buttonText,
    Color buttonColor = Colors.blue,
  }) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog.adaptive(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(foregroundColor: buttonColor),
            child: Text(buttonText ?? AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  /// Shows a dialog with custom content.
  static Future<T?> custom<T>(
    BuildContext context, {
    required String title,
    required Widget content,
    List<Widget>? actions,
  }) async {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(title),
        content: content,
        actions: actions,
      ),
    );
  }
}
