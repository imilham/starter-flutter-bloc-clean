// ignore_for_file: comment_references

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter/utils/utils.dart';

/// A universal image widget that smartly handles Network, Asset, and SVG images.
///
/// Automatically detects input type based on the [url] string:
/// - **Network**: Starts with 'http' or 'https'
/// - **Asset**: Anything else
/// - **SVG**: Ends with '.svg'
///
/// ## Usage
/// ```dart
/// CommonImage(url: 'https://site.com/img.png') // Network Image
/// CommonImage(url: 'assets/logo.svg')          // Asset SVG
/// CommonImage(url: 'assets/banner.png')        // Asset PNG
/// ```
class CommonImage extends StatelessWidget {
  /// Creates a smart image widget.
  const CommonImage({
    required this.url,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
    this.color, // Useful for SVGs
  }) : _isCircle = false;

  /// Creates a circular image (avatar style).
  const CommonImage.circle({
    required this.url,
    required double radius,
    super.key,
    this.placeholder,
    this.errorWidget,
    this.color,
  })  : width = radius * 2,
        height = radius * 2,
        fit = BoxFit.cover,
        borderRadius = null,
        _isCircle = true;

  /// The URL or Path of the image.
  ///
  /// - `http...` -> Network
  /// - `assets/...` -> Asset
  /// - `...svg` -> SVG
  final String url;

  /// Width of the image.
  final double? width;

  /// Height of the image.
  final double? height;

  /// How the image should fit within its bounds.
  final BoxFit fit;

  /// Widget to show while loading (Network only).
  final Widget? placeholder;

  /// Widget to show on error.
  final Widget? errorWidget;

  /// Border radius for rounded corners.
  final BorderRadius? borderRadius;

  /// Color filter for SVGs or images.
  final Color? color;

  final bool _isCircle;

  bool get _isNetwork => url.startsWith('http');
  bool get _isSvg => url.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Widget imageContent;

    if (_isSvg) {
      imageContent = _buildSvg(context);
    } else if (_isNetwork) {
      imageContent = _buildNetworkImage(colorScheme);
    } else {
      imageContent = _buildAssetImage(colorScheme);
    }

    if (_isCircle) {
      return imageContent.clipOval;
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageContent);
    }

    return imageContent;
  }

  Widget _buildSvg(BuildContext context) {
    // Handle Network SVG
    if (_isNetwork) {
      return SvgPicture.network(
        url,
        width: width,
        height: height,
        fit: fit,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        placeholderBuilder: (context) => placeholder ?? _defaultPlaceholder(Theme.of(context).colorScheme),
      );
    }
    // Handle Asset SVG
    return SvgPicture.asset(
      url,
      width: width,
      height: height,
      fit: fit,
      colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }

  Widget _buildNetworkImage(ColorScheme colorScheme) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      color: color,
      // Memory Hygiene: Only decode what's needed for the display slot
      memCacheWidth: width != null && width! > 0 && width != double.infinity ? width!.toInt() : null,
      memCacheHeight: height != null && height! > 0 && height != double.infinity ? height!.toInt() : null,
      placeholder: (context, url) => placeholder ?? _defaultPlaceholder(colorScheme),
      errorWidget: (context, url, error) => errorWidget ?? _defaultError(colorScheme),
    );
  }

  Widget _buildAssetImage(ColorScheme colorScheme) {
    return Image.asset(
      url,
      width: width,
      height: height,
      fit: fit,
      color: color,
      // Memory Hygiene: Only decode what's needed for the display slot
      cacheWidth: width != null && width! > 0 && width != double.infinity ? width!.toInt() : null,
      cacheHeight: height != null && height! > 0 && height != double.infinity ? height!.toInt() : null,
      errorBuilder: (context, error, stackTrace) => errorWidget ?? _defaultError(colorScheme),
    );
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
        size: 24,
      ),
    );
  }
}
