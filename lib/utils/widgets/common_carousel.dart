// ignore_for_file: avoid_positional_boolean_parameters

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:starter/utils/widgets/common_image.dart';

/// A premium carousel widget that wraps [CarouselSlider] with consistent styling,
/// animations, and indicators.
///
/// ## Features
/// - 🔄 Auto-play support
/// - 🎨 Integrated indicators
/// - 🖼️ Default image handling
/// - 📱 Responsive design
///
/// ## Example
/// ```dart
/// CommonCarousel.images(
///   imageUrls: ['https://...', 'https://...'],
///   height: 200,
/// )
/// ```
class CommonCarousel extends StatefulWidget {
  /// Creates a generic carousel with custom widgets.
  const CommonCarousel({
    required this.items,
    super.key,
    this.height = 200.0,
    this.autoPlay = true,
    this.enlargeCenterPage = true,
    this.viewportFraction = 0.85,
    this.showIndicator = true,
    this.indicatorActiveColor,
    this.indicatorInactiveColor,
    this.indicatorSize = const Size(8, 8),
    this.indicatorActiveWidth = 24.0,
    this.indicatorBuilder,
    this.onPageChanged,
  });

  /// Creates a carousel specifically for images.
  factory CommonCarousel.images({
    required List<String> imageUrls,
    double height = 200.0,
    bool autoPlay = true,
    bool showIndicator = true,
    Color? indicatorActiveColor,
    Color? indicatorInactiveColor,
    Size indicatorSize = const Size(8, 8),
    double indicatorActiveWidth = 24.0,
    Widget Function(BuildContext, int, bool)? indicatorBuilder,
    BoxFit fit = BoxFit.cover,
  }) {
    return CommonCarousel(
      height: height,
      autoPlay: autoPlay,
      showIndicator: showIndicator,
      indicatorActiveColor: indicatorActiveColor,
      indicatorInactiveColor: indicatorInactiveColor,
      indicatorSize: indicatorSize,
      indicatorActiveWidth: indicatorActiveWidth,
      indicatorBuilder: indicatorBuilder,
      items: imageUrls.map((url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CommonImage(
            url: url,
            width: double.infinity,
            height: double.infinity,
            fit: fit,
          ),
        );
      }).toList(),
    );
  }

  /// The widgets to display in the carousel.
  final List<Widget> items;

  /// Height of the carousel.
  final double height;

  /// Whether to auto-play the slides.
  final bool autoPlay;

  /// Whether current page should be larger than side pages.
  final bool enlargeCenterPage;

  /// Fraction of the viewport that each page should occupy.
  final double viewportFraction;

  /// Whether to show the bottom indicator dots.
  final bool showIndicator;

  /// Color of the active indicator dot.
  final Color? indicatorActiveColor;

  /// Color of the inactive indicator dots.
  final Color? indicatorInactiveColor;

  /// Size of the indicators (inactive width/height, active height).
  final Size indicatorSize;

  /// Width of the active indicator.
  final double indicatorActiveWidth;

  /// Custom builder for indicators.
  ///
  /// If provided, this will be used instead of the default dot style.
  final Widget Function(BuildContext context, int index, bool isActive)? indicatorBuilder; // ignore: always_put_required_named_parameters_first

  /// Callback when page changes.
  final ValueChanged<int>? onPageChanged;

  @override
  State<CommonCarousel> createState() => _CommonCarouselState();
}

class _CommonCarouselState extends State<CommonCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: widget.items,
          options: CarouselOptions(
            height: widget.height,
            autoPlay: widget.autoPlay,
            enlargeCenterPage: widget.enlargeCenterPage,
            viewportFraction: widget.viewportFraction,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
              widget.onPageChanged?.call(index);
            },
          ),
        ),
        if (widget.showIndicator) ...[
          const SizedBox(height: 16),
          _buildIndicator(),
        ],
      ],
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.items.asMap().entries.map((entry) {
        final index = entry.key;
        final isSelected = _currentIndex == index;

        if (widget.indicatorBuilder != null) {
          return widget.indicatorBuilder!(context, index, isSelected);
        }

        final colorScheme = Theme.of(context).colorScheme;
        final activeColor = widget.indicatorActiveColor ?? colorScheme.primary;
        final inactiveColor = widget.indicatorInactiveColor ?? colorScheme.onSurface.withValues(alpha: 0.2);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          width: isSelected ? widget.indicatorActiveWidth : widget.indicatorSize.width,
          height: widget.indicatorSize.height,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.indicatorSize.height / 2),
            color: isSelected ? activeColor : inactiveColor,
          ),
        );
      }).toList(),
    );
  }
}
