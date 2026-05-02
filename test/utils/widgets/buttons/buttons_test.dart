import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/widgets/buttons/buttons.dart';

void main() {
  group('CommonButton.primary', () {
    testWidgets('renders with required parameters', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonButton.primary(
              label: 'Test Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonButton.primary(
              label: 'Test',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Test'));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('shows loading spinner when isLoading is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonButton.primary(
              label: 'Test',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test'), findsNothing);
    });

    testWidgets('disables button when isLoading is true', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonButton.primary(
              label: 'Test',
              isLoading: true,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton), warnIfMissed: false);
      await tester.pump();

      expect(pressed, isFalse);
    });

    testWidgets('displays icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonButton.primary(
              label: 'Save',
              prefixIcon: Icons.save,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.save), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('small size creates small button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonButton.primary(
              label: 'Small',
              size: CommonButtonSize.small,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Small'), findsOneWidget);
    });
  });

  group('CommonButton.outline', () {
    testWidgets('renders with required parameters', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonButton.outline(
              label: 'Cancel',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Cancel'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('shows loading spinner when isLoading is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonButton.outline(
              label: 'Cancel',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Cancel'), findsNothing);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonButton.outline(
              label: 'Cancel',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Cancel'));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('small size creates small button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonButton.outline(
              label: 'Small',
              size: CommonButtonSize.small,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Small'), findsOneWidget);
    });
  });

  group('CommonButtonSize enum', () {
    test('has correct values', () {
      expect(CommonButtonSize.values.length, 2);
      expect(CommonButtonSize.small, isNotNull);
      expect(CommonButtonSize.large, isNotNull);
    });
  });

  group('IconPosition enum', () {
    test('has correct values', () {
      expect(IconPosition.values.length, 2);
      expect(IconPosition.leading, isNotNull);
      expect(IconPosition.trailing, isNotNull);
    });
  });
}
