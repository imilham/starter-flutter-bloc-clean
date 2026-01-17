import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Extensions for number formatting and layout shortcuts.
extension NumExtensions on num {
  /// Formats the number as currency.
  ///
  /// Example:
  /// ```dart
  /// 1000.toCurrency(locale: 'en_US', symbol: '\$') // "$1,000.00"
  /// ```
  String toCurrency({String? locale, String? symbol, int decimalDigits = 2}) {
    return NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format(this);
  }

  /// Formats the number in compact form.
  ///
  /// Example:
  /// ```dart
  /// 1000.compact() // "1K"
  /// 1500000.compact() // "1.5M"
  /// ```
  String compact({String? locale}) {
    return NumberFormat.compact(locale: locale).format(this);
  }

  /// Formats the number as a percentage.
  ///
  /// Example:
  /// ```dart
  /// 0.5.toPercent() // "50%"
  /// 0.123.toPercent() // "12%"
  /// ```
  String toPercent({String? locale, int decimalDigits = 0}) {
    return NumberFormat.percentPattern(locale).format(this);
  }

  /// Returns a [SizedBox] with this number as height.
  SizedBox get heightBox => SizedBox(height: toDouble());

  /// Returns a [SizedBox] with this number as width.
  SizedBox get widthBox => SizedBox(width: toDouble());

  /// Returns this value clamped between [min] and [max].
  num clamp(num min, num max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }
}
