// ignore_for_file: comment_references

import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

/// A themed elevated button with built-in loading state.
///
/// This widget wraps [ElevatedButton] with common functionality:
/// - 🔄 Built-in loading spinner (no Builder wrapper needed)
/// - 📐 Size variants: small (220px) or large (full width)
/// - 🎨 Theme-aware styling
/// - 🖼️ Optional icon support
///
/// ## Example Usage
/// ```dart
/// // Large button (full width) - default
/// CommonElevatedButton(
///   text: 'Sign In',
///   onPressed: () => authService.login(),
/// )
///
/// // Small button (220px fixed width)
/// CommonElevatedButton.small(
///   text: 'Save',
///   onPressed: () => save(),
/// )
///
/// // With loading state
/// CommonElevatedButton(
///   text: 'Sign In',
///   isLoading: isAuthLoading,
///   onPressed: () => authService.login(),
/// )
/// ```
///
/// See also:
/// - [CommonSecondaryButton] for outlined button variant.
class CommonElevatedButton extends StatelessWidget {
  /// Creates an elevated button with optional loading state.
  ///
  /// By default creates a large (full width) button.
  const CommonElevatedButton({
    required this.text,
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.size = ButtonSize.large,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.width,
    this.height,
  });

  /// Creates a small-sized elevated button (220px width).
  factory CommonElevatedButton.small({
    required String text,
    Key? key,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    IconPosition iconPosition = IconPosition.leading,
  }) {
    return CommonElevatedButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      iconPosition: iconPosition,
      size: ButtonSize.small,
    );
  }

  /// The button label text.
  final String text;

  /// Callback when button is pressed.
  ///
  /// If null or [isLoading] is true, button appears disabled.
  final VoidCallback? onPressed;

  /// Whether to show loading spinner instead of text.
  ///
  /// When true:
  /// - Shows a circular progress indicator
  /// - Disables the button tap
  final bool isLoading;

  /// Optional icon to display alongside text.
  final IconData? icon;

  /// Position of the icon relative to text.
  ///
  /// Defaults to [IconPosition.leading].
  final IconPosition iconPosition;

  /// Size variant of the button.
  ///
  /// - [ButtonSize.small]: 220px fixed width
  /// - [ButtonSize.large]: full width (default)
  final ButtonSize size;

  /// Optional background color override.
  final Color? backgroundColor;

  /// Optional foreground color (text/icon) override.
  final Color? foregroundColor;

  /// Optional text style override.
  final TextStyle? textStyle;

  final double? width;
  final double? height;

  /// Button height is defaults to 48px.
  static const double _defaultHeight = 48;

  /// Small button width.
  static const double _smallWidth = 220;

  /// Spinner/icon size.
  static const double _iconSize = 18;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final child = isLoading ? _buildLoader(colorScheme) : _buildContent();

    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        textStyle: textStyle,
        minimumSize: Size(
          width ?? (size == ButtonSize.small ? _smallWidth : double.infinity),
          height ?? _defaultHeight,
        ),
      ),
      child: child,
    );

    // Large buttons expand to full width unless width is specified
    if (size == ButtonSize.large && width == null) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }

  /// Builds the loading spinner.
  Widget _buildLoader(ColorScheme colorScheme) {
    return RepaintBoundary(
      child: SizedBox(
        height: _iconSize,
        width: _iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
            colorScheme.onPrimary.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }

  /// Builds the button content (text with optional icon).
  Widget _buildContent() {
    if (icon == null) {
      return Text(text);
    }

    final iconWidget = Icon(icon, size: _iconSize);
    const gap = Gap.small8;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: iconPosition == IconPosition.leading ? [iconWidget, gap, Text(text)] : [Text(text), gap, iconWidget],
    );
  }
}
