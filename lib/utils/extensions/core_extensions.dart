import 'package:intl/intl.dart';

/// Core extensions for primitive types and common collections.
///
/// This file contains:
/// 1. [StringExtensions] - Validation and formatting.
/// 2. [ListExtensions] - Safe access.
/// 3. [DateTimeExtensions] - Formatting and comparisons.

// -----------------------------------------------------------------------------
// STRING EXTENSIONS
// -----------------------------------------------------------------------------

extension StringExtensions on String? {
  /// Returns this string if not null, otherwise returns [defaultValue] or empty string.
  ///
  /// Example:
  /// ```dart
  /// String? name;
  /// print(name.orEmpty); // ""
  /// print(name.orEmpty('Guest')); // "Guest"
  /// ```
  String orEmpty([String defaultValue = '']) => this ?? defaultValue;

  /// Returns true if the string is null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns true if the string is NOT null and NOT empty.
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}

extension StringUtils on String {
  /// Returns the string with the first letter capitalized.
  ///
  /// Example:
  /// ```dart
  /// 'hello'.capitalize // 'Hello'
  /// ```
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Validates if the string is a valid email format.
  ///
  /// Example:
  /// ```dart
  /// 'test@example.com'.isValidEmail // true
  /// 'invalid-email'.isValidEmail // false
  /// ```
  bool get isValidEmail {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this);
  }
}

// -----------------------------------------------------------------------------
// LIST EXTENSIONS
// -----------------------------------------------------------------------------

extension ListExtensions<T> on List<T>? {
  /// Safely returns the element at [index] or null if index is out of bounds.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2];
  /// list.safeElementAt(0); // 1
  /// list.safeElementAt(5); // null
  /// ```
  T? safeElementAt(int index) {
    if (this == null) return null;
    if (index < 0 || index >= this!.length) return null;
    return this![index];
  }

  /// Returns true if the list is null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

// -----------------------------------------------------------------------------
// DATE EXTENSIONS
// -----------------------------------------------------------------------------

extension DateTimeExtensions on DateTime {
  /// Formatting extension using [DateFormat].
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().format('dd MMM yyyy'); // "02 Jan 2026"
  /// ```
  String format(String pattern, {String? locale}) {
    return DateFormat(pattern, locale).format(this);
  }

  /// Returns true if the date is today.
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Returns true if the date is yesterday.
  bool get isYesterday {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  /// Formats the date with ordinal suffix (e.g., "1st January 2026").
  ///
  /// The rest of the date uses 'MMMM yyyy' pattern by default.
  String get formatWithSuffix {
    var suffix = 'th';
    if (day == 1 || day == 21 || day == 31) {
      suffix = 'st';
    } else if (day == 2 || day == 22) {
      suffix = 'nd';
    } else if (day == 3 || day == 23) {
      suffix = 'rd';
    }
    return '$day$suffix ${DateFormat('MMMM yyyy').format(this)}';
  }
}

// -----------------------------------------------------------------------------
// DATE STRING EXTENSIONS
// -----------------------------------------------------------------------------

extension DateStringExtensions on String {
  /// Converts a date string to [DateTime].
  ///
  /// Returns null if the string cannot be parsed.
  /// Supports ISO 8601 formats (e.g., "2026-01-06T12:00:00").
  DateTime? get toDateTime => DateTime.tryParse(this);

  /// Formats a date string to a specific [pattern].
  ///
  /// Example:
  /// ```dart
  /// "2026-01-06".formatDate("dd MMM yyyy"); // "06 Jan 2026"
  /// "invalid".formatDate("dd MMM yyyy"); // "invalid"
  /// ```
  ///
  /// If parsing fails, returns the original string.
  String formatDate(String pattern, {String? locale}) {
    final date = DateTime.tryParse(this);
    if (date == null) return this;
    return DateFormat(pattern, locale).format(date);
  }

  /// Formats the date string with ordinal suffix (e.g., "1st January 2026").
  ///
  /// Returns original string if parsing fails.
  String get formatWithSuffix {
    final date = DateTime.tryParse(this);
    if (date == null) return this;
    return date.formatWithSuffix;
  }
}
