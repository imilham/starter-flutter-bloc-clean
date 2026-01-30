import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/extensions/app_colors_extension.dart';

void main() {
  const appColors = AppColors(
    shimmerColor: Color(0xFFE0E0E0),
    shimmerBgColor: Color(0xFFF5F5F5),
    success: Color(0xFF4CAF50),
    bottomNavbarColor: Color(0xffF1FCFD),
    bottomNavbarSelectedColor: Color(0xffFBE5E9),
    pink: Color(0xffEA7085),
    coreTextColor: Color(0xff464646),
    black400: Color(0xff969696),
    deemphasizedText: Color(0xff878787),
    themeLerpColor: Color(0xffFF5722),
  );

  group('AppColors Extension', () {
    test('copyWith creates a new instance with updated values', () {
      final newColors = appColors.copyWith(
        shimmerColor: Colors.red,
        success: Colors.blue,
      ) as AppColors;

      expect(newColors.shimmerColor, Colors.red);
      expect(newColors.success, Colors.blue);
      expect(newColors.shimmerBgColor, appColors.shimmerBgColor); // Unchanged
    });

    test('lerp works correctly', () {
      final otherColors = appColors.copyWith(
        shimmerColor: Colors.black,
      );

      // ignore: invalid_use_of_protected_member
      final lerped = appColors.lerp(otherColors, 0.5) as AppColors;

      expect(lerped.shimmerColor, Color.lerp(appColors.shimmerColor, Colors.black, 0.5));
      expect(lerped.shimmerBgColor, appColors.shimmerBgColor);
    });
  });
}
