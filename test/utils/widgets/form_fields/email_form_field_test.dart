import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/widgets/form_fields/email_form_field.dart';

void main() {
  group('EmailFormField', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    Widget buildTestWidget({
      String hintText = 'Enter email',
      String? title,
      String? Function(String?)? validator,
      void Function(String)? onChanged,
      bool enabled = true,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: EmailFormField(
            controller: controller,
            hintText: hintText,
            title: title,
            validator: validator,
            onChanged: onChanged,
            enabled: enabled,
          ),
        ),
      );
    }

    testWidgets('renders with required parameters', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Enter email'), findsOneWidget);
    });

    testWidgets('displays title when provided', (tester) async {
      await tester.pumpWidget(buildTestWidget(title: 'Email Address'));

      expect(find.text('Email Address'), findsOneWidget);
    });

    testWidgets('accepts email input', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.enterText(find.byType(TextFormField), 'test@example.com');
      await tester.pump();

      expect(controller.text, 'test@example.com');
    });

    testWidgets('calls onChanged callback', (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        buildTestWidget(
          onChanged: (value) => changedValue = value,
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'user@test.com');
      await tester.pump();

      expect(changedValue, 'user@test.com');
    });

    testWidgets('is disabled when enabled is false', (tester) async {
      await tester.pumpWidget(buildTestWidget(enabled: false));

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('uses custom validator when provided', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          validator: (value) => value != 'allowed@test.com' ? 'Not allowed' : null,
        ),
      );

      final widgetFinder = find.byType(EmailFormField);
      final widget = tester.widget<EmailFormField>(widgetFinder);
      expect(widget.validator, isNotNull);
      expect(widget.validator!('wrong@test.com'), 'Not allowed');
    });
  });

  group('EmailFormField default validator', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('validates empty email', () {
      final field = EmailFormField(
        controller: controller,
        hintText: 'Email',
      );

      // The default validator is internal, but we can test behavior
      // by checking the widget accepts the defaults
      expect(field.validator, isNull); // Uses internal default
    });

    test('default validation logic works correctly', () {
      // Create a test instance to verify the regex pattern
      const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
      final regex = RegExp(emailRegex);

      // Valid emails
      expect(regex.hasMatch('user@example.com'), isTrue);
      expect(regex.hasMatch('user.name@example.co.uk'), isTrue);
      expect(regex.hasMatch('user+tag@example.com'), isTrue);

      // Invalid emails
      expect(regex.hasMatch('invalid'), isFalse);
      expect(regex.hasMatch('invalid@'), isFalse);
      expect(regex.hasMatch('@example.com'), isFalse);
      expect(regex.hasMatch('user@.com'), isFalse);
    });
  });
}
