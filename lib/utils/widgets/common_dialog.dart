import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

/// A utility class for showing common dialogs.
///
/// ## Usage
/// ```dart
/// // Confirmation dialog
/// final confirmed = await CommonDialog.confirm(
///   context,
///   title: 'Delete Item',
///   message: 'Are you sure you want to delete this item?',
/// );
///
/// // Alert dialog
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
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Yes',
    String cancelText = 'No',
    bool isDangerous = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: isDangerous
                ? TextButton.styleFrom(
                    foregroundColor: context.colorScheme.error,
                  )
                : null,
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Shows a simple alert dialog with an OK button.
  static Future<void> alert(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'OK',
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(buttonText),
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
