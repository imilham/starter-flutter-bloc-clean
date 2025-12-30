/// App-wide animation duration constants.
///
/// Use these constants instead of hardcoded durations for consistency.
///
/// ## Usage
/// ```dart
/// AnimatedContainer(
///   duration: AppDurations.fast,
///   ...
/// )
/// ```
class AppDurations {
  AppDurations._();

  /// Instant: 0ms (no animation)
  static const Duration zero = Duration.zero;

  /// Fast animation: 150ms
  ///
  /// Use for: button feedback, hover states
  static const Duration fast = Duration(milliseconds: 150);

  /// Normal animation: 300ms (default)
  ///
  /// Use for: most transitions, page changes
  static const Duration normal = Duration(milliseconds: 300);

  /// Slow animation: 500ms
  ///
  /// Use for: complex transitions, emphasis
  static const Duration slow = Duration(milliseconds: 500);

  /// Extra slow: 800ms
  ///
  /// Use for: splash screens, loading animations
  static const Duration slower = Duration(milliseconds: 800);
}
