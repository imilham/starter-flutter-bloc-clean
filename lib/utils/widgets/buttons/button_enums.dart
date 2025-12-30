/// Button size and position enums for common button components.
library;

/// Button size variants.
///
/// Controls the width of buttons. Height is always 48px.
enum ButtonSize {
  /// Small button: fixed width 220px
  ///
  /// Use for compact spaces or inline actions.
  small,

  /// Large button: full width (double.infinity)
  ///
  /// Default size for primary CTAs.
  large,
}

/// Icon position within a button.
enum IconPosition {
  /// Icon appears before the text.
  leading,

  /// Icon appears after the text.
  trailing,
}
