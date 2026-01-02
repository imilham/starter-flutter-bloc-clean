import 'package:flutter/material.dart';

/// Extension on [TextStyle] for common font weight adjustments.
extension TextStyleExtension on TextStyle {
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
}
