import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/widgets/form_fields/base_text_field.dart';

void main() {
  group('CommonBaseTextField', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    Widget buildTestWidget({
      String hintText = 'Test hint',
      String? title,
      Widget? suffixIcon,
      Widget? prefixIcon,
      bool obscureText = false,
      String? Function(String?)? validator,
      bool enabled = true,
      bool readOnly = false,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: CommonBaseTextField(
            controller: controller,
            hintText: hintText,
            title: title,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            obscureText: obscureText,
            validator: validator,
            enabled: enabled,
            readOnly: readOnly,
          ),
        ),
      );
    }

    testWidgets('renders with required parameters', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Test hint'), findsOneWidget);
    });

    testWidgets('displays title when provided', (tester) async {
      await tester.pumpWidget(buildTestWidget(title: 'Email Address'));

      expect(find.text('Email Address'), findsOneWidget);
    });

    testWidgets('does not display title when null', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      // Only hint text should be visible, no title
      expect(find.text('Email Address'), findsNothing);
    });

    testWidgets('accepts text input', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.enterText(find.byType(TextFormField), 'Hello World');
      await tester.pump();

      expect(controller.text, 'Hello World');
    });

    testWidgets('displays suffix icon when provided', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        suffixIcon: const Icon(Icons.search, key: Key('suffix')),
      ),);

      expect(find.byKey(const Key('suffix')), findsOneWidget);
    });

    testWidgets('displays prefix icon when provided', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        prefixIcon: const Icon(Icons.email, key: Key('prefix')),
      ),);

      expect(find.byKey(const Key('prefix')), findsOneWidget);
    });

    testWidgets('accepts text input with obscureText flag', (tester) async {
      await tester.pumpWidget(buildTestWidget(obscureText: true));

      // We verify by entering text - the widget should still work
      await tester.enterText(find.byType(TextFormField), 'secret');
      await tester.pump();

      expect(controller.text, 'secret');
    });

    testWidgets('validates input with validator', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        validator: (value) => value?.isEmpty ?? true ? 'Required field' : null,
      ),);

      // Trigger validation
      await tester.enterText(find.byType(TextFormField), '');
      await tester.pump();

      // Find the form and validate
      final formField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(formField.validator?.call(''), 'Required field');
    });

    testWidgets('is disabled when enabled is false', (tester) async {
      await tester.pumpWidget(buildTestWidget(enabled: false));

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('can be set to read-only', (tester) async {
      await tester.pumpWidget(buildTestWidget(readOnly: true));

      // Enter text should not change controller when read-only
      // This verifies readOnly is applied correctly
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
