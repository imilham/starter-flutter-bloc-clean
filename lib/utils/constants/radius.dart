import 'package:flutter/widgets.dart';

/// App-wide border radius constants for consistent rounded corners.
///
/// ## Usage
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     borderRadius: AppRadius.md12,  // 12px all corners
///   ),
/// )
/// ```
class AppRadius {
  AppRadius._();

  // ─────────────────────────────────────────────────────────────────────
  // RADIUS VALUES (Raw doubles)
  // ─────────────────────────────────────────────────────────────────────

  /// Extra small radius: 4px
  static const double xs4 = 4;

  /// Small radius: 8px
  static const double sm8 = 8;

  /// Medium radius: 12px
  static const double md12 = 12;

  /// Large radius: 16px
  static const double lg16 = 16;

  /// Extra large radius: 24px
  static const double xl24 = 24;

  /// Full/pill radius: 999px
  static const double full999 = 999;

  // ─────────────────────────────────────────────────────────────────────
  // BORDER RADIUS (Pre-built for convenience)
  // ─────────────────────────────────────────────────────────────────────

  /// Extra small: 4px all corners
  static const extraSmall4 = BorderRadius.all(Radius.circular(xs4));

  /// Small: 8px all corners
  static const small8 = BorderRadius.all(Radius.circular(sm8));

  /// Medium: 12px all corners
  static const medium12 = BorderRadius.all(Radius.circular(md12));

  /// Large: 16px all corners
  static const large16 = BorderRadius.all(Radius.circular(lg16));

  /// Extra large: 24px all corners
  static const extraLarge24 = BorderRadius.all(Radius.circular(xl24));

  /// Full/pill: 999px all corners
  static const pill999 = BorderRadius.all(Radius.circular(full999));
}
