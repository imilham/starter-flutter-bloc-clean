import 'package:flutter/material.dart';

/// Extensions for [TextStyle] to allow chaining and easy modifications.
extension TextStyleExtensions on TextStyle? {
  /// Returns a copy of the text style with [FontWeight.bold].
  TextStyle? get bold => this?.copyWith(fontWeight: FontWeight.bold);

  /// Returns a copy of the text style with [FontWeight.w600].
  TextStyle? get semiBold => this?.copyWith(fontWeight: FontWeight.w600);

  /// Returns a copy of the text style with [FontWeight.w500].
  TextStyle? get medium => this?.copyWith(fontWeight: FontWeight.w500);

  /// Returns a copy of the text style with [FontWeight.w400].
  TextStyle? get regular => this?.copyWith(fontWeight: FontWeight.w400);

  /// Returns a copy of the text style with [FontWeight.w300].
  TextStyle? get light => this?.copyWith(fontWeight: FontWeight.w300);

  /// Returns a copy of the text style with [FontStyle.italic].
  TextStyle? get italic => this?.copyWith(fontStyle: FontStyle.italic);

  /// Returns a copy of the text style with the given [color].
  TextStyle? setColor(Color color) => this?.copyWith(color: color);

  /// Returns a copy of the text style with the given [size].
  TextStyle? setSize(double size) => this?.copyWith(fontSize: size);

  /// Returns a copy of the text style with [TextDecoration.underline].
  TextStyle? get underline => this?.copyWith(decoration: TextDecoration.underline);
}
