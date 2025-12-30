import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/extensions/theme_extension.dart';

void main() {
  group('TextStyleExtension', () {
    testWidgets('provides access to textTheme styles', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const Scaffold();
            },
          ),
        ),
      );

      // Test that all styles are accessible
      expect(capturedContext.bodyMedium, isNotNull);
      expect(capturedContext.bodyLarge, isNotNull);
      expect(capturedContext.bodySmall, isNotNull);
      expect(capturedContext.titleLarge, isNotNull);
      expect(capturedContext.titleMedium, isNotNull);
      expect(capturedContext.titleSmall, isNotNull);
      expect(capturedContext.headlineLarge, isNotNull);
      expect(capturedContext.headlineMedium, isNotNull);
      expect(capturedContext.headlineSmall, isNotNull);
      expect(capturedContext.labelLarge, isNotNull);
      expect(capturedContext.labelMedium, isNotNull);
      expect(capturedContext.labelSmall, isNotNull);
    });

    testWidgets('provides access to theme and colorScheme', (tester) async {
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

      // Verify theme is accessible
      expect(capturedContext.theme, isNotNull);
      expect(capturedContext.colorScheme.primary, isNotNull);

      // Verify text styles use theme
      expect(capturedContext.bodyMedium, equals(capturedContext.textTheme.bodyMedium));
    });

    testWidgets('can use copyWith for overrides', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const Scaffold();
            },
          ),
        ),
      );

      final original = capturedContext.bodyMedium;
      final modified = original?.copyWith(fontWeight: FontWeight.bold);

      expect(modified?.fontWeight, FontWeight.bold);
    });
  });
}
