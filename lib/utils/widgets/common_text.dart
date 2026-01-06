import 'package:flutter/material.dart';

/// A standardized text widget with fluent API for consistent styling.
///
/// Usage:
/// ```dart
/// CommonText('Hello World').size14.bold;
/// CommonText('Title').size16.italic.setColor(Colors.blue);
/// ```
class CommonText extends StatelessWidget {
  /// Default constructor. Uses default theme body text size.
  const CommonText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontSize,
    bool? bold,
    bool? italic,
    Color? color,
    FontWeight? weight,
  })  : _bold = bold,
        _italic = italic,
        _color = color,
        _weight = weight;

  const CommonText._(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontSize,
    bool? bold,
    bool? italic,
    Color? color,
    FontWeight? weight,
  })  : _bold = bold,
        _italic = italic,
        _color = color,
        _weight = weight;

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? fontSize;

  final bool? _bold;
  final bool? _italic;
  final Color? _color;
  final FontWeight? _weight;

  // ---------------------------------------------------------------------------
  // FLUENT SIZE API
  // ---------------------------------------------------------------------------

  CommonText get size10px => _copyWith(fontSize: 10);
  CommonText get size12px => _copyWith(fontSize: 12);
  CommonText get size14px => _copyWith(fontSize: 14);
  CommonText get size16px => _copyWith(fontSize: 16);
  CommonText get size18px => _copyWith(fontSize: 18);
  CommonText get size20px => _copyWith(fontSize: 20);
  CommonText get size22px => _copyWith(fontSize: 22);
  CommonText get size24px => _copyWith(fontSize: 24);
  CommonText get size26px => _copyWith(fontSize: 26);
  CommonText get size28px => _copyWith(fontSize: 28);
  CommonText get size32px => _copyWith(fontSize: 32);

  // ---------------------------------------------------------------------------
  // FLUENT STYLE API
  // ---------------------------------------------------------------------------

  CommonText get bold => _copyWith(bold: true);
  CommonText get italic => _copyWith(italic: true);
  CommonText setColor(Color color) => _copyWith(color: color);
  CommonText setWeight(FontWeight weight) => _copyWith(weight: weight);

  CommonText _copyWith({
    double? fontSize,
    bool? bold,
    bool? italic,
    Color? color,
    FontWeight? weight,
  }) {
    return CommonText._(
      text,
      fontSize: fontSize ?? this.fontSize,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      bold: bold ?? _bold,
      italic: italic ?? _italic,
      color: color ?? _color,
      weight: weight ?? _weight,
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium;
    var resultStyle = baseStyle?.merge(style) ?? style ?? const TextStyle();

    if (fontSize != null) {
      resultStyle = resultStyle.copyWith(fontSize: fontSize);
    }

    if (_bold ?? false) {
      resultStyle = resultStyle.copyWith(fontWeight: FontWeight.bold);
    }
    if (_weight != null) {
      resultStyle = resultStyle.copyWith(fontWeight: _weight);
    }
    if (_italic ?? false) {
      resultStyle = resultStyle.copyWith(fontStyle: FontStyle.italic);
    }
    if (_color != null) {
      resultStyle = resultStyle.copyWith(color: _color);
    }

    return Text(
      text,
      style: resultStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
