import 'package:flutter/material.dart';

/// Extensions for common layout, visibility, and interaction patterns.
///
/// Reduces boilerplate for wrapping widgets in [Expanded], [Center],
/// [Visibility], [GestureDetector], etc.
extension WidgetLayoutExtension on Widget {
  // ─────────────────────────────────────────────────────────────────────
  // LAYOUT SHORTCUTS
  // ─────────────────────────────────────────────────────────────────────

  /// Wraps the widget in an [Expanded] widget.
  Widget get expanded => Expanded(child: this);

  /// Wraps the widget in a [Flexible] widget.
  Widget get flexible => Flexible(child: this);

  /// Wraps the widget in a [Center] widget.
  Widget get center => Center(child: this);

  /// Wraps the widget in an [Align] widget.
  Widget align([AlignmentGeometry alignment = Alignment.center]) => Align(alignment: alignment, child: this);

  // ─────────────────────────────────────────────────────────────────────
  // VISIBILITY
  // ─────────────────────────────────────────────────────────────────────

  /// Conditionally shows or hides the widget.
  ///
  /// If [isVisible] is false, returns empty [SizedBox].
  ///
  /// Example:
  /// ```dart
  /// LoadingSpinner().visible(isLoading)
  /// ```
  Widget visible(bool isVisible) => isVisible ? this : const SizedBox.shrink();

  // ─────────────────────────────────────────────────────────────────────
  // INTERACTION
  // ─────────────────────────────────────────────────────────────────────
}

/// Extensions for Lists of Widgets.
extension WidgetListExtension on List<Widget> {
  /// Inserts a separator widget between each item in the list.
  ///
  /// Example:
  /// ```dart
  /// [Widget1(), Widget2()].separatedBy(Gap.medium16)
  /// ```
  List<Widget> separatedBy(Widget separator) {
    if (isEmpty) return [];
    if (length == 1) return toList();

    final List<Widget> result = [];
    for (var i = 0; i < length - 1; i++) {
      result
        ..add(this[i])
        ..add(separator);
    }
    result.add(last);
    return result;
  }
}
