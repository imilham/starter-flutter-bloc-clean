import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/widgets/form_fields/phone_form_field.dart';

void main() {
  group('PhoneFormField', () {
    late TextEditingController controller;
    late FocusNode focusNode;

    setUp(() {
      controller = TextEditingController();
      focusNode = FocusNode();
    });

    tearDown(() {
      controller.dispose();
      focusNode.dispose();
    });

    Widget buildTestWidget({
      String? title,
      String initialCountryCode = '+61',
      String phoneNumberHintText = 'Enter phone number',
      String? Function(String?)? phoneNumberValidator,
      void Function(String)? onCountryCodeChanged,
      void Function(String)? onChanged,
      bool enabled = true,
      int maxPhoneLength = 13,
      int minPhoneLength = 6,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: PhoneFormField(
            phoneNumberController: controller,
            phoneFocusNode: focusNode,
            title: title,
            initialCountryCode: initialCountryCode,
            phoneNumberHintText: phoneNumberHintText,
            phoneNumberValidator: phoneNumberValidator,
            onCountryCodeChanged: onCountryCodeChanged,
            onChanged: onChanged,
            enabled: enabled,
            maxPhoneLength: maxPhoneLength,
            minPhoneLength: minPhoneLength,
          ),
        ),
      );
    }

    testWidgets('renders with required parameters', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('displays title when provided', (tester) async {
      await tester.pumpWidget(buildTestWidget(title: 'Phone Number'));

      expect(find.text('Phone Number'), findsOneWidget);
    });

    testWidgets('displays country code picker', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('+61'), findsOneWidget);
    });

    testWidgets('displays hint text', (tester) async {
      await tester.pumpWidget(buildTestWidget(phoneNumberHintText: 'Phone'));

      expect(find.text('Phone'), findsOneWidget);
    });

    testWidgets('accepts phone number input', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.enterText(find.byType(TextFormField), '0412345678');
      await tester.pump();

      expect(controller.text, '0412345678');
    });

    testWidgets('only accepts digits', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.enterText(find.byType(TextFormField), '04123abc456');
      await tester.pump();

      expect(controller.text, '04123456');
    });

    testWidgets('respects maxPhoneLength', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          maxPhoneLength: 5,
          minPhoneLength: 3,
        ),
      );

      await tester.enterText(find.byType(TextFormField), '1234567890');
      await tester.pump();

      expect(controller.text.length, 5);
    });

    testWidgets('uses custom validator', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          phoneNumberValidator: (value) {
            if (value == null || value.length < 10) {
              return 'Phone must be at least 10 digits';
            }
            return null;
          },
        ),
      );

      final widgetFinder = find.byType(PhoneFormField);
      final widget = tester.widget<PhoneFormField>(widgetFinder);
      expect(widget.phoneNumberValidator, isNotNull);
      expect(
        widget.phoneNumberValidator!('123'),
        'Phone must be at least 10 digits',
      );
    });

    testWidgets('calls onChanged callback', (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        buildTestWidget(
          onChanged: (value) => changedValue = value,
        ),
      );

      await tester.enterText(find.byType(TextFormField), '12345');
      await tester.pump();

      expect(changedValue, '12345');
    });

    testWidgets('displays initial country code', (tester) async {
      await tester.pumpWidget(buildTestWidget(initialCountryCode: '+1'));

      expect(find.text('+1'), findsOneWidget);
    });

    testWidgets('has expand_more icon for country picker', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byIcon(Icons.expand_more), findsOneWidget);
    });

    testWidgets('is disabled when enabled is false', (tester) async {
      await tester.pumpWidget(buildTestWidget(enabled: false));

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('widget accepts all configuration parameters', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          title: 'Contact',
          initialCountryCode: '+44',
          phoneNumberHintText: 'Custom hint',
          maxPhoneLength: 11,
          minPhoneLength: 8,
        ),
      );

      final widgetFinder = find.byType(PhoneFormField);
      final widget = tester.widget<PhoneFormField>(widgetFinder);

      expect(widget.title, 'Contact');
      expect(widget.initialCountryCode, '+44');
      expect(widget.phoneNumberHintText, 'Custom hint');
      expect(widget.maxPhoneLength, 11);
      expect(widget.minPhoneLength, 8);
    });
  });

  group('PhoneFormField assertions', () {
    test('throws assertion error for invalid maxPhoneLength', () {
      expect(
        () => PhoneFormField(
          phoneNumberController: TextEditingController(),
          phoneFocusNode: FocusNode(),
          maxPhoneLength: 0,
        ),
        throwsAssertionError,
      );
    });

    test('throws assertion error for minPhoneLength > maxPhoneLength', () {
      expect(
        () => PhoneFormField(
          phoneNumberController: TextEditingController(),
          phoneFocusNode: FocusNode(),
          minPhoneLength: 10,
          maxPhoneLength: 5,
        ),
        throwsAssertionError,
      );
    });
  });
}
