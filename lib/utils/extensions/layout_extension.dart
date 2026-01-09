import 'dart:math' show pi;

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

  /// Wraps the widget in a [SafeArea].
  Widget get safeArea => SafeArea(child: this);

  /// Constrains the widget to a specific size.
  ///
  /// Example:
  /// ```dart
  /// Icon(Icons.star).sizedBox(width: 48, height: 48)
  /// ```
  Widget sizedBox({double? width, double? height}) => SizedBox(width: width, height: height, child: this);

  /// Wraps the widget in an [AspectRatio] widget.
  ///
  /// Example:
  /// ```dart
  /// Image.network(url).aspectRatio(ratio: 16 / 9)
  /// ```
  Widget aspectRatio({required double ratio}) => AspectRatio(aspectRatio: ratio, child: this);

  // ─────────────────────────────────────────────────────────────────────
  // VISIBILITY & OPACITY
  // ─────────────────────────────────────────────────────────────────────

  /// Conditionally shows or hides the widget.
  ///
  /// If [isVisible] is false, returns empty [SizedBox].
  ///
  /// Example:
  /// ```dart
  /// LoadingSpinner().visible(isVisible: isLoading)
  /// ```
  Widget visible({required bool isVisible}) {
    return isVisible ? this : const SizedBox.shrink();
  }

  /// Wraps the widget in an [Opacity] widget.
  ///
  /// Example:
  /// ```dart
  /// Text('Disabled').opacity(value: 0.5)
  /// ```
  Widget opacity({required double value}) => Opacity(opacity: value, child: this);

  // ─────────────────────────────────────────────────────────────────────
  // TRANSFORMS
  // ─────────────────────────────────────────────────────────────────────

  /// Scales the widget by a given factor.
  ///
  /// Example:
  /// ```dart
  /// Icon(Icons.star).scale(factor: 1.5)
  /// ```
  Widget scale({required double factor, Alignment alignment = Alignment.center}) => Transform.scale(scale: factor, alignment: alignment, child: this);

  /// Rotates the widget by a given angle in radians.
  ///
  /// Use `pi` from `dart:math` for common angles (e.g., `pi / 2` for 90°).
  ///
  /// Example:
  /// ```dart
  /// Icon(Icons.arrow_forward).rotate(angle: pi / 4) // 45 degrees
  /// ```
  Widget rotate({required double angle, Alignment alignment = Alignment.center}) => Transform.rotate(angle: angle, alignment: alignment, child: this);

  /// Rotates the widget by a given angle in degrees.
  ///
  /// Example:
  /// ```dart
  /// Icon(Icons.arrow_forward).rotateDegrees(degrees: 45)
  /// ```
  Widget rotateDegrees({required double degrees, Alignment alignment = Alignment.center}) =>
      Transform.rotate(angle: degrees * pi / 180, alignment: alignment, child: this);

  // ─────────────────────────────────────────────────────────────────────
  // POINTER HANDLING
  // ─────────────────────────────────────────────────────────────────────

  /// Wraps the widget in an [IgnorePointer].
  ///
  /// When [isIgnoring] is true, the widget ignores pointer events.
  ///
  /// Example:
  /// ```dart
  /// Button().ignore(isIgnoring: isLoading)
  /// ```
  Widget ignore({required bool isIgnoring}) => IgnorePointer(ignoring: isIgnoring, child: this);

  /// Wraps the widget in an [AbsorbPointer].
  ///
  /// When [isAbsorbing] is true, the widget absorbs pointer events
  /// (preventing them from reaching widgets below).
  ///
  /// Example:
  /// ```dart
  /// Form().absorb(isAbsorbing: isSubmitting)
  /// ```
  Widget absorb({required bool isAbsorbing}) => AbsorbPointer(absorbing: isAbsorbing, child: this);

  // ─────────────────────────────────────────────────────────────────────
  // INTERACTION
  // ─────────────────────────────────────────────────────────────────────

  /// Wraps the widget in an [InkWell] (with ripple) or [GestureDetector] (without).
  ///
  /// Default uses [InkWell] with transparent color for ripple effect.
  /// Set [useInkWell] to false for simple [GestureDetector].
  Widget onTap(VoidCallback? onTap, {bool useInkWell = true, BorderRadius? borderRadius}) {
    if (!useInkWell) {
      return GestureDetector(onTap: onTap, child: this);
    }
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: this,
    );
  }

  /// Wraps the widget in a [GestureDetector] with long press callback.
  ///
  /// Example:
  /// ```dart
  /// ListTile().onLongPress(() => showDeleteDialog())
  /// ```
  Widget onLongPress(VoidCallback? onLongPress) => GestureDetector(onLongPress: onLongPress, child: this);

  // ─────────────────────────────────────────────────────────────────────
  // ACCESSIBILITY & UX
  // ─────────────────────────────────────────────────────────────────────

  /// Wraps the widget in a [Tooltip].
  ///
  /// Example:
  /// ```dart
  /// IconButton(icon: Icon(Icons.info)).tooltip(message: 'More information')
  /// ```
  Widget tooltip({required String message}) => Tooltip(message: message, child: this);

  /// Wraps the widget in a [Hero] for hero animations.
  ///
  /// Example:
  /// ```dart
  /// Image.asset('avatar.png').hero(tag: 'profile-avatar')
  /// ```
  Widget hero({required Object tag}) => Hero(tag: tag, child: this);

  /// Wraps the widget in [Semantics] for accessibility.
  ///
  /// Example:
  /// ```dart
  /// CustomButton().semantics(label: 'Submit form')
  /// ```
  Widget semantics({String? label, bool? button, bool? enabled}) => Semantics(
        label: label,
        button: button,
        enabled: enabled,
        child: this,
      );
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

    final result = <Widget>[];
    for (var i = 0; i < length - 1; i++) {
      result
        ..add(this[i])
        ..add(separator);
    }
    result.add(last);
    return result;
  }

  // ─────────────────────────────────────────────────────────────────────
  // LIST TO WIDGET CONVERSIONS
  // ─────────────────────────────────────────────────────────────────────

  /// Converts the list to a [Column].
  ///
  /// Example:
  /// ```dart
  /// [Text('A'), Text('B'), Text('C')].toColumn(
  ///   mainAxisAlignment: MainAxisAlignment.center,
  /// )
  /// ```
  Column toColumn({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) =>
      Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: this,
      );

  /// Converts the list to a [Row].
  ///
  /// Example:
  /// ```dart
  /// [Icon(Icons.star), Text('5.0')].toRow(
  ///   mainAxisSize: MainAxisSize.min,
  /// )
  /// ```
  Row toRow({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) =>
      Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: this,
      );

  /// Converts the list to a [Stack].
  ///
  /// Example:
  /// ```dart
  /// [backgroundImage, overlay, content].toStack(
  ///   alignment: Alignment.center,
  /// )
  /// ```
  Stack toStack({
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
  }) =>
      Stack(
        alignment: alignment,
        fit: fit,
        clipBehavior: clipBehavior,
        children: this,
      );

  /// Converts the list to a [Wrap] widget.
  ///
  /// Useful for tags, chips, or any content that should wrap to the next line.
  ///
  /// Example:
  /// ```dart
  /// tags.map((t) => Chip(label: Text(t))).toList().toWrap(spacing: 8)
  /// ```
  Wrap toWrap({
    double spacing = 0,
    double runSpacing = 0,
    WrapAlignment alignment = WrapAlignment.start,
    WrapAlignment runAlignment = WrapAlignment.start,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
  }) =>
      Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        alignment: alignment,
        runAlignment: runAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: this,
      );
}
