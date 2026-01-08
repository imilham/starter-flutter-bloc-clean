import 'dart:async';

/// Extensions for asynchronous operations.
extension FutureExtensions<T> on Future<T> {
  /// Delays the completion of this Future by [duration].
  ///
  /// Useful for ensuring a minimum display time for loading indicators (UX pacing).
  ///
  /// Example:
  /// ```dart
  /// await apiCall().delay(2.seconds);
  /// ```
  Future<T> delay(Duration duration) async {
    final result = await this;
    await Future<void>.delayed(duration);
    return result;
  }
}

/// Extensions for creating Durations from numbers comfortably.
extension NumDurationExtensions on num {
  /// Returns a Duration of this milliseconds.
  Duration get milliseconds => Duration(milliseconds: toInt());

  /// Returns a Duration of this seconds.
  Duration get seconds => Duration(seconds: toInt());

  /// Returns a Duration of this minutes.
  Duration get minutes => Duration(minutes: toInt());

  /// Returns a Duration of this hours.
  Duration get hours => Duration(hours: toInt());

  /// Returns a Duration of this days.
  Duration get days => Duration(days: toInt());
}
