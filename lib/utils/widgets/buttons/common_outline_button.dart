// ignore_for_file: comment_references

import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

/// A themed outlined button with built-in loading state.
///
/// This widget wraps [OutlinedButton] with common functionality:
/// - 🔄 Built-in loading spinner
/// - 📐 Size variants: small (220px) or large (full width)
/// - 🎨 Theme-aware styling
/// - 🖼️ Optional icon support
///
/// ## Example Usage
/// ```dart
/// // Large button (full width) - default
/// CommonSecondaryButton(
///   text: 'Cancel',
///   onPressed: () => Navigator.pop(context),
/// )
///
/// // Small button (220px fixed width)
/// CommonSecondaryButton.small(
///   text: 'Back',
/// ///   isLoading: isAuthLoading,
///   onPressed: () => goBack(),
/// )
/// ```
///
/// See also:
/// - [CommonElevatedButton] for primary action buttons.
class CommonOutlineButton extends StatelessWidget {
  /// Creates an outlined button with optional loading state.
  ///
  /// By default creates a large (full width) button.
  const CommonOutlineButton({
    required this.text,
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.size = ButtonSize.large,
    this.width,
    this.height,
    this.textStyle,
    this.alignment,
  });

  /// Creates a small-sized secondary button (220px width).
  factory CommonOutlineButton.small({
    required String text,
    Key? key,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    IconPosition iconPosition = IconPosition.leading,
  }) {
    return CommonOutlineButton(
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
  final VoidCallback? onPressed;

  /// Whether to show loading spinner instead of text.
  final bool isLoading;

  /// Optional icon to display alongside text.
  final IconData? icon;

  /// Position of the icon relative to text.
  final IconPosition iconPosition;

  /// Size variant of the button.
  ///
  /// - [ButtonSize.small]: 220px fixed width
  /// - [ButtonSize.large]: full width (default)
  final ButtonSize size;

  final double? width;
  final double? height;

  final TextStyle? textStyle;

  /// Optional alignment when specifying width. Defaults to [Alignment.center].
  final AlignmentGeometry? alignment;

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

    final button = OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
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

    // If width is specified, we wrap in Align to break parent constraints
    if (width != null) {
      return Align(
        alignment: alignment ?? Alignment.center,
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
            colorScheme.primary.withValues(alpha: 0.7),
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
