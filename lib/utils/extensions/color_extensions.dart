import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  /// Darkens the color by [amount] (0.0 to 1.0).
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  /// Lightens the color by [amount] (0.0 to 1.0).
  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  /// Converts the color to a hex string (e.g., "#FF0000").
  ///
  /// [includeAlpha] - whether to include the alpha channel.
  String toHex({bool includeHash = true, bool includeAlpha = true}) {
    var hex = value.toRadixString(16).toUpperCase().padLeft(8, '0');
    if (!includeAlpha) {
      hex = hex.substring(2);
    }
    return '${includeHash ? '#' : ''}$hex';
  }

  /// Returns true if the color is considered light.
  ///
  /// Useful for determining text color (black vs white) on top of this color.
  bool get isLight => computeLuminance() > 0.5;

  /// Returns the complementary color.
  Color get complementary {
    final hsl = HSLColor.fromColor(this);
    final hue = (hsl.hue + 180) % 360;
    return hsl.withHue(hue).toColor();
  }

  /// Shortcut for [withOpacity].
  Color opacity(double opacity) => withValues(alpha: opacity);

  /// Returns a MaterialColor swatch from this color.
  MaterialColor toMaterialColor() {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    // Use red, green, blue (0-255 integer values)
    final r = red;
    final g = green;
    final b = blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    
    for (var strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(value, swatch);
  }

  /// Smoothly interpolates to [other] color by [t].
  Color lerp(Color other, double t) => Color.lerp(this, other, t)!;
}

extension StringColorExtensions on String {
  /// Converts a hex string to a [Color].
  ///
  /// Supports formats: "RRGGBB", "AARRGGBB", "#RRGGBB", "#AARRGGBB".
  Color toColor() {
    var hexString = replaceAll('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString'; // Add alpha if missing
    }
    return Color(int.parse(hexString, radix: 16));
  }
}
