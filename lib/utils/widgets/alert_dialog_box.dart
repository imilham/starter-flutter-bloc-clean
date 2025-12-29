// ignore_for_file: comment_references

import 'package:flutter/material.dart';

/// Displays a platform-adaptive alert dialog with customizable actions.
///
/// This function shows an [AlertDialog.adaptive] that automatically adapts
/// its appearance based on the current platform (Material on Android,
/// Cupertino on iOS).
///
/// ## Features
/// - Platform-adaptive styling (Material/Cupertino)
/// - Customizable confirm and cancel buttons
/// - Theme-aware colors using [ColorScheme]
/// - Non-dismissible by barrier tap for important confirmations
///
/// ## Example Usage
/// ```dart
/// await appAdaptiveDialog(
///   context: context,
///   title: 'Delete Item',
///   content: 'Are you sure you want to delete this item?',
///   confirmText: 'Delete',
///   confirmTextColor: Colors.red,
///   cancelText: 'Cancel',
///   onConfirm: () => deleteItem(),
///   onCancel: () => print('Cancelled'),
/// );
/// ```
///
/// ## Parameters
/// - [context]: The build context for showing the dialog.
/// - [title]: The dialog title displayed prominently at the top.
/// - [content]: The main message or description of the dialog.
/// - [confirmText]: Text for the confirm button (defaults to 'OK').
/// - [onConfirm]: Callback executed when confirm button is pressed.
/// - [cancelText]: Optional text for cancel button. If null, no cancel button is shown.
/// - [onCancel]: Callback executed when cancel button is pressed.
/// - [confirmTextColor]: Custom color for the confirm button text.
/// - [barrierDismissible]: Whether tapping outside dismisses the dialog (defaults to false).
///
/// ## Design Pattern
/// This follows the **Repository Pattern** for UI utilities, providing a
/// consistent dialog interface across the application.
///
/// ## References
/// - [AlertDialog.adaptive] - Flutter's adaptive dialog widget
/// - [Material Design Dialogs](https://material.io/components/dialogs)
/// - [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/alerts)
///
/// See also:
/// - [showDialog] for the underlying dialog mechanism.
/// - [AlertDialog] for the Material Design dialog widget.
Future<void> appAdaptiveDialog({
  required BuildContext context,
  required String title,
  required String content,
  String confirmText = 'OK',
  VoidCallback? onConfirm,
  String? cancelText,
  VoidCallback? onCancel,
  Color? confirmTextColor,
  bool barrierDismissible = false,
}) async {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final textTheme = theme.textTheme;

  return showDialog<void>(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog.adaptive(
        backgroundColor: colorScheme.surface,
        title: Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          content,
          style: textTheme.bodyMedium,
        ),
        actions: <Widget>[
          // Cancel button - only shown if cancelText is provided
          if (cancelText != null)
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onCancel?.call();
              },
              child: Text(
                cancelText,
                style: textTheme.labelLarge,
              ),
            ),

          // Confirm button - always shown
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: confirmTextColor ?? colorScheme.primary,
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onConfirm?.call();
            },
            child: Text(
              confirmText,
              style: textTheme.labelLarge?.copyWith(
                color: confirmTextColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}

/// Displays a simple information dialog with a single dismiss button.
///
/// A convenience wrapper around [appAdaptiveDialog] for simple
/// informational messages that only require acknowledgment.
///
/// ## Example Usage
/// ```dart
/// await showInfoDialog(
///   context: context,
///   title: 'Success',
///   content: 'Your changes have been saved.',
/// );
/// ```
Future<void> showInfoDialog({
  required BuildContext context,
  required String title,
  required String content,
  String dismissText = 'OK',
  VoidCallback? onDismiss,
}) async {
  return appAdaptiveDialog(
    context: context,
    title: title,
    content: content,
    confirmText: dismissText,
    onConfirm: onDismiss,
  );
}

/// Displays a confirmation dialog with confirm and cancel options.
///
/// A convenience wrapper around [appAdaptiveDialog] for actions
/// that require user confirmation before proceeding.
///
/// ## Example Usage
/// ```dart
/// await showConfirmDialog(
///   context: context,
///   title: 'Logout',
///   content: 'Are you sure you want to logout?',
///   onConfirm: () => authService.logout(),
/// );
/// ```
Future<void> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  String confirmText = 'Confirm',
  String cancelText = 'Cancel',
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  Color? confirmTextColor,
}) async {
  return appAdaptiveDialog(
    context: context,
    title: title,
    content: content,
    confirmText: confirmText,
    cancelText: cancelText,
    onConfirm: onConfirm,
    onCancel: onCancel,
    confirmTextColor: confirmTextColor,
  );
}

/// Displays a destructive action confirmation dialog.
///
/// Similar to [showConfirmDialog] but styled for destructive actions
/// like deletion, with the confirm button in red by default.
///
/// ## Example Usage
/// ```dart
/// await showDestructiveDialog(
///   context: context,
///   title: 'Delete Account',
///   content: 'This action cannot be undone.',
///   onConfirm: () => deleteAccount(),
/// );
/// ```
Future<void> showDestructiveDialog({
  required BuildContext context,
  required String title,
  required String content,
  String confirmText = 'Delete',
  String cancelText = 'Cancel',
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) async {
  return appAdaptiveDialog(
    context: context,
    title: title,
    content: content,
    confirmText: confirmText,
    cancelText: cancelText,
    onConfirm: onConfirm,
    onCancel: onCancel,
    confirmTextColor: Colors.red,
  );
}
