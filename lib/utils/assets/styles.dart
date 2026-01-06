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
TextStyle headline1({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.x2xl.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontStyle: fontStyle,
    );

TextStyle headline2({Color? textColor, double? letterSpacing = 0.0, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xl.size,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontStyle: fontStyle,
    );

TextStyle headline3({Color? textColor, double? letterSpacing = 0.0, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.lg.size,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontStyle: fontStyle,
    );

TextStyle headline4({Color? textColor, double? letterSpacing = 0.0, TextDecoration? decoration, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.s.size,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      decoration: decoration,
      fontStyle: fontStyle,
    );

TextStyle headline4LinkText({Color? textColor, double? letterSpacing, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.s.size,
      letterSpacing: letterSpacing ?? 0.0,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontStyle: fontStyle,
    );

TextStyle headline5({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xs.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontStyle: fontStyle,
    );

TextStyle headline6({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.x2xs.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontStyle: fontStyle,
    );

/// Body Styles
TextStyle bodyRegular({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      height: height,
      fontSize: FontSize.s.size,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w400,
      fontStyle: fontStyle,
    );

TextStyle bodySmall({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xs.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontStyle: fontStyle,
    );

TextStyle bodyXSmall({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.x2xs.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w400,
      fontStyle: fontStyle,
    );

///Button Styles
TextStyle buttonRegular({Color? textColor, double? letterSpacing = 0.0, double? height}) => _font(
      color: textColor,
      fontSize: FontSize.s.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w700,
    );

TextStyle buttonSmall({Color? textColor, double? letterSpacing = 0.0, double? height}) => _font(
      color: textColor,
      fontSize: FontSize.xs.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w700,
    );

TextStyle buttonXSmall({Color? textColor, double? letterSpacing = 0.0, double? height}) => _font(
      color: textColor,
      fontSize: FontSize.x2xs.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w700,
    );

///Form Styles
TextStyle formBody({Color? textColor, double? letterSpacing = 0.0, double? height}) => _font(
      color: textColor,
      fontSize: FontSize.s.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
    );

TextStyle formHint({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight}) => _font(
      color: textColor,
      fontSize: FontSize.s.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w500,
    );

TextStyle tab3Xs({Color? textColor, double? letterSpacing = 0.0, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.x3xs.size,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontStyle: fontStyle,
    );

TextStyle formLabel({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.xs.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontStyle: fontStyle,
    );

/// AppBar Title Style
TextStyle appBar({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight}) => _font(
      color: textColor,
      fontSize: FontSize.s.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w600,
    );

TextStyle appBarDescription({Color? textColor, double? letterSpacing = 0.0, double? height, FontWeight? fontWeight, FontStyle? fontStyle}) => _font(
      color: textColor,
      fontSize: FontSize.x2xs.size,
      height: height,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? FontWeight.w400,
      fontStyle: fontStyle,
    );

enum FontSize {
  x2xl,
  xl,
  lg,
  md,
  s,
  xs,
  x2xs,
  x3xs,
}

extension FontSizeExtension on FontSize {
  double get size {
    switch (this) {
      case FontSize.x2xl:
        return 32;
      case FontSize.xl:
        return 24;
      case FontSize.lg:
        return 20;
      case FontSize.md:
        return 18;
      case FontSize.s:
        return 16;
      case FontSize.xs:
        return 14;
      case FontSize.x2xs:
        return 12;
      case FontSize.x3xs:
        return 10;
    }
  }
}
