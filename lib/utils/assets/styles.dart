import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized font family
TextStyle _font({
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
}) {
  return GoogleFonts.montserrat(
    textStyle: textStyle,
    color: color,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
  );
}

/// Centralized font family getter
String? get appFontFamily => _font().fontFamily;

/// Heading Styles
TextStyle headline32({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xxLarge32.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontStyle: fontStyle,
    );

TextStyle headline28({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xxLarge28.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontStyle: fontStyle,
    );

TextStyle headline24({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xLarge24.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontStyle: fontStyle,
    );

TextStyle headline18({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.medium18.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontStyle: fontStyle,
    );

TextStyle headline20({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.large20.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontStyle: fontStyle,
    );

TextStyle headline16(
        {Color? textColor, double? letterSpacing = 0.0, double? height, TextDecoration? decoration, FontWeight? fontWeight, FontStyle? fontStyle}) =>
    _font(
      color: textColor,
      fontSize: FontSize.small16.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      decoration: decoration,
      fontStyle: fontStyle,
    );

TextStyle headline14({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xSmall14.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontStyle: fontStyle,
    );

TextStyle headline12({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xxSmall12.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontStyle: fontStyle,
    );

/// Body Styles
TextStyle bodyRegular16({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      height: height,
      fontSize: FontSize.small16.size,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w400,
      fontStyle: fontStyle,
    );

TextStyle bodySmall14({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xSmall14.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontStyle: fontStyle,
    );

TextStyle bodyXSmall12({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xxSmall12.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w400,
      fontStyle: fontStyle,
    );

///Button Styles
TextStyle buttonRegular16({Color? textColor, double? letterSpacing = 0.0, double? height, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.small16.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w700,
      fontStyle: fontStyle,
    );

TextStyle buttonSmall14({Color? textColor, double? letterSpacing = 0.0, double? height, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xSmall14.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w700,
      fontStyle: fontStyle,
    );

TextStyle buttonXSmall12({Color? textColor, double? letterSpacing = 0.0, double? height, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xxSmall12.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w700,
      fontStyle: fontStyle,
    );

///Form Styles

TextStyle formHint16({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight}) => _font(
      color: textColor,
      fontSize: FontSize.small16.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w500,
    );

TextStyle tab10({Color? textColor, double? letterSpacing = 0.0, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xxxSmall10.size,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontStyle: fontStyle,
    );

TextStyle formLabel14({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xSmall14.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontStyle: fontStyle,
    );

/// Font size definitions with descriptive names including the actual pixel size
enum FontSize {
  xxxLarge48,
  xxLarge32,
  xxLarge28,
  xLarge24,
  large22,
  large20,
  medium18,
  small16,
  xSmall14,
  xxSmall12,
  xxxSmall10,
}

extension FontSizeExtension on FontSize {
  double get size {
    switch (this) {
      case FontSize.xxxLarge48:
        return 48;
      case FontSize.xxLarge32:
        return 32;
      case FontSize.xxLarge28:
        return 28;
      case FontSize.xLarge24:
        return 24;
      case FontSize.large22:
        return 22;
      case FontSize.large20:
        return 20;
      case FontSize.medium18:
        return 18;
      case FontSize.small16:
        return 16;
      case FontSize.xSmall14:
        return 14;
      case FontSize.xxSmall12:
        return 12;
      case FontSize.xxxSmall10:
        return 10;
    }
  }
}
