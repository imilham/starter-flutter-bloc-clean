import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/widgets/form_fields/password_form_field.dart';

void main() {
  group('PasswordFormField', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    Widget buildTestWidget({
      String hintText = 'Enter password',
      String? title,
      String? Function(String?)? validator,
      bool enabled = true,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: PasswordFormField(
            controller: controller,
            hintText: hintText,
            title: title,
            validator: validator,
            enabled: enabled,
          ),
        ),
      );
    }

    testWidgets('renders with required parameters', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Enter password'), findsOneWidget);
    });

    testWidgets('displays title when provided', (tester) async {
      await tester.pumpWidget(buildTestWidget(title: 'Password'));

      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('text is obscured by default (visibility_off icon shown)', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      // When obscured, visibility_off icon is shown
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('has visibility toggle icon', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('toggles password visibility on icon tap', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      // Initially obscured - visibility_off icon shown
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsNothing);

      // Tap the visibility toggle
      await tester.tap(find.byType(IconButton));
      await tester.pump();

      // Now visible - visibility icon shown
      expect(find.byIcon(Icons.visibility), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsNothing);
    });

    testWidgets('accepts password input', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.enterText(find.byType(TextFormField), 'MySecret123');
      await tester.pump();

      expect(controller.text, 'MySecret123');
    });

    testWidgets('validates password with custom validator', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        validator: (value) {
          if (value == null || value.length < 8) {
            return 'Password must be at least 8 characters';
          }
          return null;
        },
      ),);

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.validator?.call('short'), 'Password must be at least 8 characters');
      expect(textField.validator?.call('longenough'), isNull);
    });

    testWidgets('is disabled when enabled is false', (tester) async {
      await tester.pumpWidget(buildTestWidget(enabled: false));

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('toggle visibility works multiple times', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      // Toggle ON
      await tester.tap(find.byType(IconButton));
      await tester.pump();
      expect(find.byIcon(Icons.visibility), findsOneWidget);

      // Toggle OFF
      await tester.tap(find.byType(IconButton));
      await tester.pump();
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      // Toggle ON again
      await tester.tap(find.byType(IconButton));
      await tester.pump();
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });
  });

  group('PasswordFormFieldFactories', () {
    test('withMinLength creates field with min length validator', () {
      final controller = TextEditingController();

      final field = PasswordFormFieldFactories.withMinLength(
        controller: controller,
        minLength: 6,
        hintText: 'Password',
        title: 'Your Password',
      );

      expect(field.controller, controller);
      expect(field.hintText, 'Password');
      expect(field.title, 'Your Password');
      expect(field.validator!('12345'), 'Password must be at least 6 characters');
      expect(field.validator!('123456'), isNull);
      expect(field.validator!(''), 'Password is required');

      controller.dispose();
    });
  });
}
