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
  /// Creates a circular loader with adaptive styling.
  ///
  /// - In Light Theme: Shows dark variant (Primary color).
  /// - In Dark Theme: Shows light variant (White/OnSurface).
  const CommonCircularLoader({super.key})
      : isLightColor = null,
        size = 17.0,
        strokeWidth = 4.0;

  /// Creates a circular loader with explicit LIGHT styling (White).
  ///
  /// Best used on dark backgrounds (e.g., primary buttons, dark containers).
  const CommonCircularLoader.light({super.key})
      : isLightColor = true,
        size = 17.0,
        strokeWidth = 4.0;

  /// Creates a circular loader with explicit DARK styling (Primary/Black).
  ///
  /// Best used on light backgrounds (e.g., white cards, light containers).
  const CommonCircularLoader.dark({super.key})
      : isLightColor = false,
        size = 17.0,
        strokeWidth = 4.0;

  /// Creates a custom-sized circular loader.
  const CommonCircularLoader.custom({
    super.key,
    this.size = 17.0,
    this.strokeWidth = 4.0,
    this.isLightColor,
  });

  /// If true, forces light color (White).
  /// If false, forces dark color (Primary).
  /// If null, adapts to theme:
  /// - Dark Theme -> Light Color (true)
  /// - Light Theme -> Dark Color (false)
  final bool? isLightColor;

  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkTheme = theme.brightness == Brightness.dark;

    // Determine if we should use the "Light Color" (White)
    // 1. Explicitly requested (.light())
    // 2. OR Adaptive (null) AND we are in Dark Theme (Dark BG needs Light Color)
    final useLightColor = isLightColor ?? isDarkTheme;

    // Dark Color: Primary (Purple) or Secondary or Black.
    // Light Color: OnPrimary (White) or OnSurface (White).
    final indicatorColor = useLightColor ? colorScheme.onPrimary : colorScheme.primary;

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(indicatorColor.withValues(alpha: 0.5)),
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
