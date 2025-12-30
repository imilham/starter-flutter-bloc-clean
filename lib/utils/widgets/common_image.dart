// ignore_for_file: comment_references

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A widget for displaying network images with caching and placeholder.
///
/// Uses [CachedNetworkImage] internally for efficient caching.
///
/// ## Usage
/// ```dart
/// // Basic usage
/// CommonImage(url: 'https://example.com/image.jpg')
///
/// // With custom size
/// CommonImage(
///   url: 'https://example.com/image.jpg',
///   width: 100,
///   height: 100,
/// )
///
/// // Circle avatar style
/// CommonImage.circle(
///   url: 'https://example.com/avatar.jpg',
///   radius: 40,
/// )
/// ```
class CommonImage extends StatelessWidget {
  /// Creates a network image with caching.
  const CommonImage({
    required this.url,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
  }) : _isCircle = false;

  /// Creates a circular network image (for avatars).
  const CommonImage.circle({
    required this.url,
    required double radius,
    super.key,
    this.placeholder,
    this.errorWidget,
  })  : width = radius * 2,
        height = radius * 2,
        fit = BoxFit.cover,
        borderRadius = null,
        _isCircle = true;

  /// The URL of the image to display.
  final String url;

  /// Width of the image.
  final double? width;

  /// Height of the image.
  final double? height;

  /// How the image should fit within its bounds.
  final BoxFit fit;

  /// Widget to show while loading.
  final Widget? placeholder;

  /// Widget to show on error.
  final Widget? errorWidget;

  /// Border radius for rounded corners.
  final BorderRadius? borderRadius;

  final bool _isCircle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Widget image = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => placeholder ?? _defaultPlaceholder(colorScheme),
      errorWidget: (context, url, error) => errorWidget ?? _defaultError(colorScheme),
    );

    if (_isCircle) {
      return ClipOval(child: image);
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    return image;
  }

  Widget _defaultPlaceholder(ColorScheme colorScheme) {
    return Container(
      width: width,
      height: height,
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _defaultError(ColorScheme colorScheme) {
    return Container(
      width: width,
      height: height,
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.broken_image,
        color: colorScheme.outline,
        size: 32,
      ),
    );
  }
}
