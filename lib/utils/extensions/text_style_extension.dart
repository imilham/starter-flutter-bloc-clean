import 'package:flutter/material.dart';

/// Extension to provide fluent API for [TextStyle].
///
/// This allows for concise styling overrides:
/// ```dart
/// style: bodyRegular16().bold.setColor(Colors.red)
/// ```
extension TextStyleFluentExtension on TextStyle {
  /// Returns a copy of this text style with [FontWeight.bold].
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  /// Returns a copy of this text style with [FontWeight.w600].
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  /// Returns a copy of this text style with [FontWeight.w500].
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// Returns a copy of this text style with [FontWeight.w400].
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  /// Returns a copy of this text style with [FontWeight.w300].
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  /// Returns a copy of this text style with [FontStyle.italic].
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  /// Returns a copy of this text style with the given [color].
  TextStyle setColor(Color color) => copyWith(color: color);

  /// Returns a copy of this text style with [TextDecoration.underline].
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);

  /// Returns a copy of this text style with [TextDecoration.lineThrough].
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
}
