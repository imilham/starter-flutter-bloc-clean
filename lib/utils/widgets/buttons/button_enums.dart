/// Button size and position enums for common button components.
library;

/// Defines the size variants for the buttons.
enum CommonButtonSize {
  /// Small button: fixed width 220px (standard across TRP-L projects).
  small,

  /// Large button: uses theme default (typically full width).
  large,
}

/// Icon position within a button.
enum IconPosition {
  /// Icon appears before the text.
  leading,

  /// Icon appears after the text.
  trailing,
}
