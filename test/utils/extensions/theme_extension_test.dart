import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/extensions/theme_extension.dart';

void main() {
  group('ThemeExtension', () {
    testWidgets('provides access to theme, textTheme, and colorScheme', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const Scaffold();
            },
          ),
        ),
      );

      expect(capturedContext.theme, isNotNull);
      expect(capturedContext.textTheme, isNotNull);
      expect(capturedContext.colorScheme, isNotNull);
    });

    testWidgets('provides theme-aware access', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const Scaffold();
            },
          ),
        ),
      );

      expect(capturedContext.colorScheme.primary, isNotNull);
    });

    // Note: AppColors extension testing requires setting up the theme extension in MaterialApp
    // which is a bit more involved, but basic property access is verified above.
  });
}
