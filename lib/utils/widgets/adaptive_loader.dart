import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

/// A compact circular progress indicator with theme-aware styling.
///
/// This widget provides a consistent loading indicator across the application
/// with support for both light and dark variants.
///
/// ## Features
/// - 🎨 Theme-aware color scheme integration
/// - 🌓 Light and dark mode variants
/// - 📏 Compact size suitable for buttons and inline use
/// - ⚡ Const constructors for optimal performance
///
/// ## Example Usage
/// ```dart
/// // Default loader (uses onSecondary color)
/// ElevatedButton(
///   onPressed: isLoading ? null : onSubmit,
///   child: isLoading
///     ? const CommonCircularLoader()
///     : const Text('Submit'),
/// )
///
/// // Dark variant (uses onPrimary color)
/// Container(
///   color: Theme.of(context).colorScheme.primary,
///   child: const CommonCircularLoader.dark(),
/// )
/// ```
///
/// ## Design Pattern
/// Uses **Factory Constructor Pattern** for variant creation, allowing
/// compile-time const initialization for better performance.
///
/// ## References
/// - [CircularProgressIndicator](https://api.flutter.dev/flutter/material/CircularProgressIndicator-class.html)
/// - [Material Design Progress Indicators](https://material.io/components/progress-indicators)
///
/// See also:
/// - [LinearProgressIndicator] for horizontal progress indicators.
/// - [RefreshIndicator] for pull-to-refresh functionality.
class CommonCircularLoader extends StatelessWidget {
  /// Creates a circular loader with default (light) styling.
  ///
  /// Uses [ColorScheme.onSecondary] with 50% opacity for the indicator color.
  /// Best used on secondary colored backgrounds or buttons.
  const CommonCircularLoader({super.key})
      : isDark = false,
        size = 17.0,
        strokeWidth = 4.0;

  /// Creates a circular loader with dark styling.
  ///
  /// Uses [ColorScheme.onPrimary] with 50% opacity for the indicator color.
  /// Best used on primary colored backgrounds or dark surfaces.
  const CommonCircularLoader.dark({super.key})
      : isDark = true,
        size = 17.0,
        strokeWidth = 4.0;

  /// Creates a custom-sized circular loader.
  ///
  /// Allows customization of [size] and [strokeWidth] while maintaining
  /// the same color behavior as the default constructor.
  const CommonCircularLoader.custom({
    super.key,
    this.size = 17.0,
    this.strokeWidth = 4.0,
    this.isDark = false,
  });

  /// Whether to use dark mode styling.
  ///
  /// When true, uses [ColorScheme.onPrimary].
  /// When false, uses [ColorScheme.onSecondary].
  final bool isDark;

  /// The size (width and height) of the loader.
  ///
  /// Defaults to 17.0 logical pixels.
  final double size;

  /// The width of the circular stroke.
  ///
  /// Defaults to 4.0 logical pixels.
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Select color based on dark/light variant
    final indicatorColor = isDark ? colorScheme.onPrimary.withValues(alpha: 0.5) : colorScheme.onSecondary.withValues(alpha: 0.5);

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
      ),
    );
  }
}

/// A full-screen loading overlay with optional message.
///
/// Covers the entire screen with a semi-transparent barrier and displays
/// a centered loading indicator with an optional status message.
///
/// ## Example Usage
/// ```dart
/// Stack(
///   children: [
///     MyPageContent(),
///     if (isLoading)
///       const FullScreenLoader(message: 'Saving...'),
///   ],
/// )
/// ```
class FullScreenLoader extends StatelessWidget {
  /// Creates a full-screen loading overlay.
  ///
  /// The [message] is displayed below the loading indicator if provided.
  const FullScreenLoader({
    super.key,
    this.message,
    this.barrierColor,
  });

  /// Optional message to display below the loader.
  final String? message;

  /// Background color for the barrier overlay.
  ///
  /// Defaults to black with 50% opacity.
  final Color? barrierColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: barrierColor ?? Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              Gap.medium16,
              Text(
                message!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
