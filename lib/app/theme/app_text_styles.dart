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

/// Extension on [BuildContext] to provide theme-aware text styles.
///
/// Uses the theme as the single source of truth for base styles,
/// allowing optional overrides for specific use cases.
///
/// Usage:
/// ```dart
/// Text('Title', style: context.headline24())
/// Text('Body', style: context.bodyRegular16())
/// Text('Custom', style: context.bodyRegular16(color: Colors.red, fontWeight: FontWeight.bold))
/// ```
extension TextStyleExtension on BuildContext {
  /// Gets the TextTheme from the current theme
  TextTheme get _textTheme => Theme.of(this).textTheme;

  // Headline Styles - Maps to theme display and headline styles
  TextStyle headline32({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.displayLarge != null, 'Theme displayLarge must be defined');
    return _textTheme.displayLarge!.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  TextStyle headline28({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.displayMedium != null, 'Theme displayMedium must be defined');
    return _textTheme.displayMedium!.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  TextStyle headline24({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.displaySmall != null, 'Theme displaySmall must be defined');
    return _textTheme.displaySmall!.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  TextStyle headline20({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.headlineMedium != null, 'Theme headlineMedium must be defined');
    return _textTheme.headlineMedium!.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  TextStyle headline18({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.headlineSmall != null, 'Theme headlineSmall must be defined');
    return _textTheme.headlineSmall!.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  TextStyle headline16({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.titleMedium != null, 'Theme titleMedium must be defined');
    return _textTheme.titleMedium!.copyWith(
      fontSize: 16,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  TextStyle headline14({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.titleSmall != null, 'Theme titleSmall must be defined');
    return _textTheme.titleSmall!.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  TextStyle headline12({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.labelSmall != null, 'Theme labelSmall must be defined');
    return _textTheme.labelSmall!.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  // Body Styles - Maps to theme body styles
  TextStyle bodyRegular16({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.bodyLarge != null, 'Theme bodyLarge must be defined');
    return _textTheme.bodyLarge!.copyWith(
      fontSize: 16,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  TextStyle bodyMedium14({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.bodyMedium != null, 'Theme bodyMedium must be defined');
    return _textTheme.bodyMedium!.copyWith(
      fontSize: 14,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  TextStyle bodyXSmall12({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.bodySmall != null, 'Theme bodySmall must be defined');
    return _textTheme.bodySmall!.copyWith(
      fontSize: 12,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  /// body small 10 --- custom addition
    TextStyle bodyXSsmall10({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.bodySmall != null, 'Theme bodySmall must be defined');
    return _textTheme.bodySmall!.copyWith(
      fontSize: 12,
      color: color,
      letterSpacing: letterSpacing ?? 1,
      height: height ?? 1,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  // Button Styles - Maps to theme label styles
  TextStyle buttonRegular16({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.labelLarge != null, 'Theme labelLarge must be defined');
    return _textTheme.labelLarge!.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  TextStyle buttonSmall14({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.labelMedium != null, 'Theme labelMedium must be defined');
    return _textTheme.labelMedium!.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  TextStyle buttonXSmall12({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.labelSmall != null, 'Theme labelSmall must be defined');
    return _textTheme.labelSmall!.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  // Form Styles - Uses body styles as base
  TextStyle formHint16({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.bodyLarge != null, 'Theme bodyLarge must be defined');
    return _textTheme.bodyLarge!.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  TextStyle formLabel14({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    assert(_textTheme.bodyMedium != null, 'Theme bodyMedium must be defined');
    return _textTheme.bodyMedium!.copyWith(
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }

  // Tab Style - Small labels
  TextStyle tab10({Color? color, double? letterSpacing, double? height, FontWeight? fontWeight, FontStyle? fontStyle, TextDecoration? decoration, String? fontFamily, List<Shadow>? shadows, Color? decorationColor, TextDecorationStyle? decorationStyle}) {
    // Using labelSmall but overriding to 10px for tabs
    assert(_textTheme.labelSmall != null, 'Theme labelSmall must be defined');
    return _textTheme.labelSmall!.copyWith(
      fontSize: 10, // Override to ensure 10px for tabs
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
      shadows: shadows,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
    );
  }
}
