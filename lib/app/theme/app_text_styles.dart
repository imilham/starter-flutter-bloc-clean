import 'package:flutter/material.dart';
import 'package:starter/app/app.dart';

/// Extension to provide fluent API for [TextStyle].
///
/// This allows for concise styling overrides:
/// ```dart
/// style: bodyRegular16().bold.setColor(Colors.red)
/// ```
extension TextStyleFluentExtension on TextStyle {
  /// Re-wraps the style in GoogleFonts to ensure dynamic weights are fetched correctly.
  TextStyle _rewrap(TextStyle style) {
    if (fontFamily != null) {
      if (fontFamily!.contains('Platypi')) {
        return platypi(
          fontSize: style.fontSize,
          color: style.color,
          fontWeight: style.fontWeight,
          letterSpacing: style.letterSpacing,
          height: style.height,
          fontStyle: style.fontStyle,
          decoration: style.decoration,
          shadows: style.shadows,
          decorationColor: style.decorationColor,
          decorationStyle: style.decorationStyle,
        );
      } else if (fontFamily!.contains('Noto') || fontFamily!.contains('noto')) {
        return notoSans(
          fontSize: style.fontSize,
          color: style.color,
          fontWeight: style.fontWeight,
          letterSpacing: style.letterSpacing,
          height: style.height,
          fontStyle: style.fontStyle,
          decoration: style.decoration,
          shadows: style.shadows,
          decorationColor: style.decorationColor,
          decorationStyle: style.decorationStyle,
        );
      }
    }
    return style;
  }

  /// Returns a copy of this text style with [FontWeight.w900].
  TextStyle get extraBold => _rewrap(copyWith(fontWeight: FontWeight.w900));

  /// Returns a copy of this text style with [FontWeight.bold].
  TextStyle get bold => _rewrap(copyWith(fontWeight: FontWeight.w700));

  /// Returns a copy of this text style with [FontWeight.w600].
  TextStyle get semiBold => _rewrap(copyWith(fontWeight: FontWeight.w600));

  /// Returns a copy of this text style with [FontWeight.w500].
  TextStyle get medium => _rewrap(copyWith(fontWeight: FontWeight.w500));

  /// Returns a copy of this text style with [FontWeight.w400].
  TextStyle get regular => _rewrap(copyWith(fontWeight: FontWeight.w400));

  /// Returns a copy of this text style with [FontWeight.w300].
  TextStyle get light => _rewrap(copyWith(fontWeight: FontWeight.w300));

  /// Returns a copy of this text style with [FontWeight.w200].
  TextStyle get extraLight => _rewrap(copyWith(fontWeight: FontWeight.w200));

  /// Returns a copy of this text style with [FontStyle.italic].
  TextStyle get italic => _rewrap(copyWith(fontStyle: FontStyle.italic));

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
  TextStyle headline32(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.displayLarge != null, 'Theme displayLarge must be defined');
    return platypi(
      fontSize: _textTheme.displayLarge!.fontSize,
      color: color ?? _textTheme.displayLarge!.color,
      fontWeight: fontWeight ?? _textTheme.displayLarge!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.displayLarge!.letterSpacing,
      height: height ?? _textTheme.displayLarge!.height,
      fontStyle: fontStyle ?? _textTheme.displayLarge!.fontStyle,
      decoration: decoration ?? _textTheme.displayLarge!.decoration,
      shadows: shadows ?? _textTheme.displayLarge!.shadows,
      decorationColor: decorationColor ?? _textTheme.displayLarge!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.displayLarge!.decorationStyle,
    );
  }

  TextStyle headline28(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.displayMedium != null, 'Theme displayMedium must be defined');
    return platypi(
      fontSize: _textTheme.displayMedium!.fontSize,
      color: color ?? _textTheme.displayMedium!.color,
      fontWeight: fontWeight ?? _textTheme.displayMedium!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.displayMedium!.letterSpacing,
      height: height ?? _textTheme.displayMedium!.height,
      fontStyle: fontStyle ?? _textTheme.displayMedium!.fontStyle,
      decoration: decoration ?? _textTheme.displayMedium!.decoration,
      shadows: shadows ?? _textTheme.displayMedium!.shadows,
      decorationColor: decorationColor ?? _textTheme.displayMedium!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.displayMedium!.decorationStyle,
    );
  }

  TextStyle headline24(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.displaySmall != null, 'Theme displaySmall must be defined');
    return platypi(
      fontSize: _textTheme.displaySmall!.fontSize,
      color: color ?? _textTheme.displaySmall!.color,
      fontWeight: fontWeight ?? _textTheme.displaySmall!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.displaySmall!.letterSpacing,
      height: height ?? _textTheme.displaySmall!.height,
      fontStyle: fontStyle ?? _textTheme.displaySmall!.fontStyle,
      decoration: decoration ?? _textTheme.displaySmall!.decoration,
      shadows: shadows ?? _textTheme.displaySmall!.shadows,
      decorationColor: decorationColor ?? _textTheme.displaySmall!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.displaySmall!.decorationStyle,
    );
  }

  TextStyle headline20(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.headlineMedium != null, 'Theme headlineMedium must be defined');
    return platypi(
      fontSize: _textTheme.headlineMedium!.fontSize,
      color: color ?? _textTheme.headlineMedium!.color,
      fontWeight: fontWeight ?? _textTheme.headlineMedium!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.headlineMedium!.letterSpacing,
      height: height ?? _textTheme.headlineMedium!.height,
      fontStyle: fontStyle ?? _textTheme.headlineMedium!.fontStyle,
      decoration: decoration ?? _textTheme.headlineMedium!.decoration,
      shadows: shadows ?? _textTheme.headlineMedium!.shadows,
      decorationColor: decorationColor ?? _textTheme.headlineMedium!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.headlineMedium!.decorationStyle,
    );
  }

  TextStyle headline18(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.headlineSmall != null, 'Theme headlineSmall must be defined');
    return platypi(
      fontSize: _textTheme.headlineSmall!.fontSize,
      color: color ?? _textTheme.headlineSmall!.color,
      fontWeight: fontWeight ?? _textTheme.headlineSmall!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.headlineSmall!.letterSpacing,
      height: height ?? _textTheme.headlineSmall!.height,
      fontStyle: fontStyle ?? _textTheme.headlineSmall!.fontStyle,
      decoration: decoration ?? _textTheme.headlineSmall!.decoration,
      shadows: shadows ?? _textTheme.headlineSmall!.shadows,
      decorationColor: decorationColor ?? _textTheme.headlineSmall!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.headlineSmall!.decorationStyle,
    );
  }

  TextStyle headline16(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.titleMedium != null, 'Theme titleMedium must be defined');
    return platypi(
      fontSize: 16,
      color: color ?? _textTheme.titleMedium!.color,
      fontWeight: fontWeight ?? _textTheme.titleMedium!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.titleMedium!.letterSpacing,
      height: height ?? _textTheme.titleMedium!.height,
      fontStyle: fontStyle ?? _textTheme.titleMedium!.fontStyle,
      decoration: decoration ?? _textTheme.titleMedium!.decoration,
      shadows: shadows ?? _textTheme.titleMedium!.shadows,
      decorationColor: decorationColor ?? _textTheme.titleMedium!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.titleMedium!.decorationStyle,
    );
  }

  TextStyle headline14(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.titleSmall != null, 'Theme titleSmall must be defined');
    return platypi(
      fontSize: _textTheme.titleSmall!.fontSize,
      color: color ?? _textTheme.titleSmall!.color,
      fontWeight: fontWeight ?? _textTheme.titleSmall!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.titleSmall!.letterSpacing,
      height: height ?? _textTheme.titleSmall!.height,
      fontStyle: fontStyle ?? _textTheme.titleSmall!.fontStyle,
      decoration: decoration ?? _textTheme.titleSmall!.decoration,
      shadows: shadows ?? _textTheme.titleSmall!.shadows,
      decorationColor: decorationColor ?? _textTheme.titleSmall!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.titleSmall!.decorationStyle,
    );
  }

  TextStyle headline12(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.labelSmall != null, 'Theme labelSmall must be defined');
    return notoSans(
      fontSize: _textTheme.labelSmall!.fontSize,
      color: color ?? _textTheme.labelSmall!.color,
      fontWeight: fontWeight ?? _textTheme.labelSmall!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.labelSmall!.letterSpacing,
      height: height ?? _textTheme.labelSmall!.height,
      fontStyle: fontStyle ?? _textTheme.labelSmall!.fontStyle,
      decoration: decoration ?? _textTheme.labelSmall!.decoration,
      shadows: shadows ?? _textTheme.labelSmall!.shadows,
      decorationColor: decorationColor ?? _textTheme.labelSmall!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.labelSmall!.decorationStyle,
    );
  }

  TextStyle headline10(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.labelSmall != null, 'Theme labelSmall must be defined');
    return notoSans(
      fontSize: 10,
      color: color ?? _textTheme.labelSmall!.color,
      fontWeight: fontWeight ?? _textTheme.labelSmall!.fontWeight,
      letterSpacing: letterSpacing ?? 0.5,
      height: height ?? _textTheme.labelSmall!.height,
      fontStyle: fontStyle ?? _textTheme.labelSmall!.fontStyle,
      decoration: decoration ?? _textTheme.labelSmall!.decoration,
      shadows: shadows ?? _textTheme.labelSmall!.shadows,
      decorationColor: decorationColor ?? _textTheme.labelSmall!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.labelSmall!.decorationStyle,
    );
  }

  // Body Styles - Maps to theme body styles
  TextStyle bodyRegular16(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.bodyLarge != null, 'Theme bodyLarge must be defined');
    return notoSans(
      fontSize: 16,
      color: color ?? _textTheme.bodyLarge!.color,
      fontWeight: fontWeight ?? _textTheme.bodyLarge!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.bodyLarge!.letterSpacing,
      height: height ?? _textTheme.bodyLarge!.height,
      fontStyle: fontStyle ?? _textTheme.bodyLarge!.fontStyle,
      decoration: decoration ?? _textTheme.bodyLarge!.decoration,
      shadows: shadows ?? _textTheme.bodyLarge!.shadows,
      decorationColor: decorationColor ?? _textTheme.bodyLarge!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.bodyLarge!.decorationStyle,
    );
  }

  TextStyle bodyMedium14(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.bodyMedium != null, 'Theme bodyMedium must be defined');
    return notoSans(
      fontSize: 14,
      color: color ?? _textTheme.bodyMedium!.color,
      fontWeight: fontWeight ?? _textTheme.bodyMedium!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.bodyMedium!.letterSpacing,
      height: height ?? _textTheme.bodyMedium!.height,
      fontStyle: fontStyle ?? _textTheme.bodyMedium!.fontStyle,
      decoration: decoration ?? _textTheme.bodyMedium!.decoration,
      shadows: shadows ?? _textTheme.bodyMedium!.shadows,
      decorationColor: decorationColor ?? _textTheme.bodyMedium!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.bodyMedium!.decorationStyle,
    );
  }

  TextStyle bodyXSmall12(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.bodySmall != null, 'Theme bodySmall must be defined');
    return notoSans(
      fontSize: _textTheme.bodySmall!.fontSize,
      color: color ?? _textTheme.bodySmall!.color,
      fontWeight: fontWeight ?? _textTheme.bodySmall!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.bodySmall!.letterSpacing,
      height: height ?? _textTheme.bodySmall!.height,
      fontStyle: fontStyle ?? _textTheme.bodySmall!.fontStyle,
      decoration: decoration ?? _textTheme.bodySmall!.decoration,
      shadows: shadows ?? _textTheme.bodySmall!.shadows,
      decorationColor: decorationColor ?? _textTheme.bodySmall!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.bodySmall!.decorationStyle,
    );
  }

  /// body small 10 --- custom addition
  TextStyle bodyXSsmall10(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.bodySmall != null, 'Theme bodySmall must be defined');
    return notoSans(
      fontSize: 10,
      color: color ?? _textTheme.bodySmall!.color,
      fontWeight: fontWeight ?? _textTheme.bodySmall!.fontWeight,
      letterSpacing: letterSpacing ?? 0.5,
      height: height ?? 1,
      fontStyle: fontStyle ?? _textTheme.bodySmall!.fontStyle,
      decoration: decoration ?? _textTheme.bodySmall!.decoration,
      shadows: shadows ?? _textTheme.bodySmall!.shadows,
      decorationColor: decorationColor ?? _textTheme.bodySmall!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.bodySmall!.decorationStyle,
    );
  }

  // Button Styles - Maps to theme label styles
  TextStyle buttonRegular16(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.labelLarge != null, 'Theme labelLarge must be defined');
    return notoSans(
      fontSize: _textTheme.labelLarge!.fontSize,
      color: color ?? _textTheme.labelLarge!.color,
      fontWeight: fontWeight ?? _textTheme.labelLarge!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.labelLarge!.letterSpacing,
      height: height ?? _textTheme.labelLarge!.height,
      fontStyle: fontStyle ?? _textTheme.labelLarge!.fontStyle,
      decoration: decoration ?? _textTheme.labelLarge!.decoration,
      shadows: shadows ?? _textTheme.labelLarge!.shadows,
      decorationColor: decorationColor ?? _textTheme.labelLarge!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.labelLarge!.decorationStyle,
    );
  }

  TextStyle buttonSmall14(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.labelMedium != null, 'Theme labelMedium must be defined');
    return notoSans(
      fontSize: _textTheme.labelMedium!.fontSize,
      color: color ?? _textTheme.labelMedium!.color,
      fontWeight: fontWeight ?? _textTheme.labelMedium!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.labelMedium!.letterSpacing,
      height: height ?? _textTheme.labelMedium!.height,
      fontStyle: fontStyle ?? _textTheme.labelMedium!.fontStyle,
      decoration: decoration ?? _textTheme.labelMedium!.decoration,
      shadows: shadows ?? _textTheme.labelMedium!.shadows,
      decorationColor: decorationColor ?? _textTheme.labelMedium!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.labelMedium!.decorationStyle,
    );
  }

  TextStyle buttonXSmall12(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.labelSmall != null, 'Theme labelSmall must be defined');
    return notoSans(
      fontSize: _textTheme.labelSmall!.fontSize,
      color: color ?? _textTheme.labelSmall!.color,
      fontWeight: fontWeight ?? _textTheme.labelSmall!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.labelSmall!.letterSpacing,
      height: height ?? _textTheme.labelSmall!.height,
      fontStyle: fontStyle ?? _textTheme.labelSmall!.fontStyle,
      decoration: decoration ?? _textTheme.labelSmall!.decoration,
      shadows: shadows ?? _textTheme.labelSmall!.shadows,
      decorationColor: decorationColor ?? _textTheme.labelSmall!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.labelSmall!.decorationStyle,
    );
  }

  // Form Styles - Uses body styles as base
  TextStyle formHint16(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.bodyLarge != null, 'Theme bodyLarge must be defined');
    return notoSans(
      fontSize: _textTheme.bodyLarge!.fontSize,
      color: color ?? _textTheme.bodyLarge!.color,
      fontWeight: fontWeight ?? _textTheme.bodyLarge!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.bodyLarge!.letterSpacing,
      height: height ?? _textTheme.bodyLarge!.height,
      fontStyle: fontStyle ?? _textTheme.bodyLarge!.fontStyle,
      decoration: decoration ?? _textTheme.bodyLarge!.decoration,
      shadows: shadows ?? _textTheme.bodyLarge!.shadows,
      decorationColor: decorationColor ?? _textTheme.bodyLarge!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.bodyLarge!.decorationStyle,
    );
  }

  TextStyle formLabel14(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.bodyMedium != null, 'Theme bodyMedium must be defined');
    return notoSans(
      fontSize: _textTheme.bodyMedium!.fontSize,
      color: color ?? _textTheme.bodyMedium!.color,
      fontWeight: fontWeight ?? _textTheme.bodyMedium!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.bodyMedium!.letterSpacing,
      height: height ?? _textTheme.bodyMedium!.height,
      fontStyle: fontStyle ?? _textTheme.bodyMedium!.fontStyle,
      decoration: decoration ?? _textTheme.bodyMedium!.decoration,
      shadows: shadows ?? _textTheme.bodyMedium!.shadows,
      decorationColor: decorationColor ?? _textTheme.bodyMedium!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.bodyMedium!.decorationStyle,
    );
  }

  // Tab Style - Small labels
  TextStyle tab10(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    // Using labelSmall but overriding to 10px for tabs
    assert(_textTheme.labelSmall != null, 'Theme labelSmall must be defined');
    return notoSans(
      fontSize: 10, // Override to ensure 10px for tabs,
      color: color ?? _textTheme.labelSmall!.color,
      fontWeight: fontWeight ?? _textTheme.labelSmall!.fontWeight,
      letterSpacing: letterSpacing ?? _textTheme.labelSmall!.letterSpacing,
      height: height ?? _textTheme.labelSmall!.height,
      fontStyle: fontStyle ?? _textTheme.labelSmall!.fontStyle,
      decoration: decoration ?? _textTheme.labelSmall!.decoration,
      shadows: shadows ?? _textTheme.labelSmall!.shadows,
      decorationColor: decorationColor ?? _textTheme.labelSmall!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.labelSmall!.decorationStyle,
    );
  }

  // Selected tab label - bold variant of [tab10].
  TextStyle tabSelected10(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.labelSmall != null, 'Theme labelSmall must be defined');
    return notoSans(
      fontSize: 10,
      color: color ?? _textTheme.labelSmall!.color,
      fontWeight: fontWeight ?? FontWeight.w700,
      letterSpacing: letterSpacing ?? _textTheme.labelSmall!.letterSpacing,
      height: height ?? _textTheme.labelSmall!.height,
      fontStyle: fontStyle ?? _textTheme.labelSmall!.fontStyle,
      decoration: decoration ?? _textTheme.labelSmall!.decoration,
      shadows: shadows ?? _textTheme.labelSmall!.shadows,
      decorationColor: decorationColor ?? _textTheme.labelSmall!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.labelSmall!.decorationStyle,
    );
  }

  // Unselected tab label - regular variant of [tab10].
  TextStyle tabUnselected10(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.labelSmall != null, 'Theme labelSmall must be defined');
    return notoSans(
      fontSize: 10,
      color: color ?? _textTheme.labelSmall!.color,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? _textTheme.labelSmall!.letterSpacing,
      height: height ?? _textTheme.labelSmall!.height,
      fontStyle: fontStyle ?? _textTheme.labelSmall!.fontStyle,
      decoration: decoration ?? _textTheme.labelSmall!.decoration,
      shadows: shadows ?? _textTheme.labelSmall!.shadows,
      decorationColor: decorationColor ?? _textTheme.labelSmall!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.labelSmall!.decorationStyle,
    );
  }

  // Navigation Bar Styles - 16px label-style text for app bars.
  TextStyle navBarTitle16(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.titleMedium != null, 'Theme titleMedium must be defined');
    return platypi(
      fontSize: 16,
      color: color ?? _textTheme.titleMedium!.color,
      fontWeight: fontWeight ?? FontWeight.w500,
      letterSpacing: letterSpacing ?? _textTheme.titleMedium!.letterSpacing,
      height: height ?? _textTheme.titleMedium!.height,
      fontStyle: fontStyle ?? _textTheme.titleMedium!.fontStyle,
      decoration: decoration ?? _textTheme.titleMedium!.decoration,
      shadows: shadows ?? _textTheme.titleMedium!.shadows,
      decorationColor: decorationColor ?? _textTheme.titleMedium!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.titleMedium!.decorationStyle,
    );
  }

  TextStyle navBarAction16(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.titleMedium != null, 'Theme titleMedium must be defined');
    return platypi(
      fontSize: 16,
      color: color ?? _textTheme.titleMedium!.color,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? _textTheme.titleMedium!.letterSpacing,
      height: height ?? _textTheme.titleMedium!.height,
      fontStyle: fontStyle ?? _textTheme.titleMedium!.fontStyle,
      decoration: decoration ?? _textTheme.titleMedium!.decoration,
      shadows: shadows ?? _textTheme.titleMedium!.shadows,
      decorationColor: decorationColor ?? _textTheme.titleMedium!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.titleMedium!.decorationStyle,
    );
  }

  // Alert dialog button label (bold, 14px).
  TextStyle alertDialogButton14(
      {Color? color,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      String? fontFamily,
      List<Shadow>? shadows,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,}) {
    assert(_textTheme.labelMedium != null, 'Theme labelMedium must be defined');
    return notoSans(
      fontSize: 14,
      color: color ?? _textTheme.labelMedium!.color,
      fontWeight: fontWeight ?? FontWeight.w700,
      letterSpacing: letterSpacing ?? _textTheme.labelMedium!.letterSpacing,
      height: height ?? _textTheme.labelMedium!.height,
      fontStyle: fontStyle ?? _textTheme.labelMedium!.fontStyle,
      decoration: decoration ?? _textTheme.labelMedium!.decoration,
      shadows: shadows ?? _textTheme.labelMedium!.shadows,
      decorationColor: decorationColor ?? _textTheme.labelMedium!.decorationColor,
      decorationStyle: decorationStyle ?? _textTheme.labelMedium!.decorationStyle,
    );
  }
}
