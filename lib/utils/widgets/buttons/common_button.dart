import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

part 'primary_button.dart';
part 'outline_button.dart';
part 'text_button.dart';
part 'button_content.dart';

// ═══════════════════════════════════════════════════════════════
// COMMON BUTTON FACADE
// ═══════════════════════════════════════════════════════════════

/// The primary entry point for all buttons in the application.
///
/// This class follows the **Facade Pattern**—it provides a simple, consolidated API
/// (`CommonButton.primary`, `CommonButton.outline`, `CommonButton.text`) while
/// delegating the actual rendering to dedicated single-responsibility widgets
/// (`_PrimaryButton`, `_OutlineButton`, `_GhostButton`).
///
/// This approach provides **Great Developer Experience (DX)** while maintaining
/// **SOLID Principles** internally.
abstract class CommonButton {
  /// Creates a Primary (Elevated) button.
  /// Automatically inherits styling from [ThemeData.elevatedButtonTheme].
  static Widget primary({
    required VoidCallback? onPressed,
    String? label,
    Widget? child,
    bool isLoading = false,
    bool isEnabled = true,
    CommonButtonSize size = CommonButtonSize.large,
    Size? minimumSize,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Color? backgroundColor,
    Color? foregroundColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    OutlinedBorder? shape,
    double? elevation,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    bool autofocus = false,
    Key? key,
  }) {
    return _PrimaryButton(
      key: key,
      onPressed: onPressed,
      label: label,
      isLoading: isLoading,
      isEnabled: isEnabled,
      size: size,
      minimumSize: minimumSize,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      textStyle: textStyle,
      padding: padding,
      shape: shape,
      elevation: elevation,
      onLongPress: onLongPress,
      focusNode: focusNode,
      autofocus: autofocus,
      child: child,
    );
  }

  /// Creates an Outlined (Secondary) button.
  /// Automatically inherits styling from [ThemeData.outlinedButtonTheme].
  static Widget outline({
    required VoidCallback? onPressed,
    String? label,
    Widget? child,
    bool isLoading = false,
    bool isEnabled = true,
    CommonButtonSize size = CommonButtonSize.large,
    Size? minimumSize,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Color? backgroundColor,
    Color? foregroundColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    OutlinedBorder? shape,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    bool autofocus = false,
    Key? key,
  }) {
    return _OutlineButton(
      key: key,
      onPressed: onPressed,
      label: label,
      isLoading: isLoading,
      isEnabled: isEnabled,
      size: size,
      minimumSize: minimumSize,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      textStyle: textStyle,
      padding: padding,
      shape: shape,
      onLongPress: onLongPress,
      focusNode: focusNode,
      autofocus: autofocus,
      child: child,
    );
  }

  /// Creates a Text button.
  /// Automatically inherits styling from [ThemeData.textButtonTheme].
  static Widget text({
    required VoidCallback? onPressed,
    String? label,
    Widget? child,
    bool isLoading = false,
    bool isEnabled = true,
    CommonButtonSize size = CommonButtonSize.large,
    Size? minimumSize,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Color? backgroundColor,
    Color? foregroundColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    OutlinedBorder? shape,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    bool autofocus = false,
    Key? key,
  }) {
    return _GhostButton(
      key: key,
      onPressed: onPressed,
      label: label,
      isLoading: isLoading,
      isEnabled: isEnabled,
      size: size,
      minimumSize: minimumSize,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      textStyle: textStyle,
      padding: padding,
      shape: shape,
      onLongPress: onLongPress,
      focusNode: focusNode,
      autofocus: autofocus,
      child: child,
    );
  }
}
