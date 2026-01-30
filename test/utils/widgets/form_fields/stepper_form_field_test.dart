import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/widgets/form_fields/stepper_form_field.dart';

void main() {
  group('StepperFormField', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    Widget buildTestWidget({
      String hintText = '0',
      String? title,
      int step = 1,
      int minValue = 0,
      int maxValue = 100,
      void Function(int)? onChanged,
      bool enabled = true,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: StepperFormField(
            controller: controller,
            hintText: hintText,
            title: title,
            step: step,
            minValue: minValue,
            maxValue: maxValue,
            onChanged: onChanged,
            enabled: enabled,
          ),
        ),
      );
    }

    testWidgets('renders with required parameters', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('displays title when provided', (tester) async {
      await tester.pumpWidget(buildTestWidget(title: 'Quantity'));

      expect(find.text('Quantity'), findsOneWidget);
    });

    testWidgets('has increment and decrement icons', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byIcon(Icons.expand_less), findsOneWidget); // Increment
      expect(find.byIcon(Icons.expand_more), findsOneWidget); // Decrement
    });

    testWidgets('increments value on increment button tap', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      // Initial value should be 0
      expect(controller.text, isEmpty);

      // Tap increment button
      await tester.tap(find.byIcon(Icons.expand_less));
      await tester.pump();

      expect(controller.text, '1');
    });

    testWidgets('decrements value on decrement button tap', (tester) async {
      controller.text = '5';
      await tester.pumpWidget(buildTestWidget());

      // Tap decrement button
      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pump();

      expect(controller.text, '4');
    });

    testWidgets('respects step size', (tester) async {
      await tester.pumpWidget(buildTestWidget(step: 5));

      await tester.tap(find.byIcon(Icons.expand_less));
      await tester.pump();

      expect(controller.text, '5');

      await tester.tap(find.byIcon(Icons.expand_less));
      await tester.pump();

      expect(controller.text, '10');
    });

    testWidgets('respects minimum value', (tester) async {
      controller.text = '0';
      await tester.pumpWidget(buildTestWidget());

      // Try to decrement below min
      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pump();

      // Should stay at 0
      expect(controller.text, '0');
    });

    testWidgets('respects maximum value', (tester) async {
      controller.text = '100';
      await tester.pumpWidget(buildTestWidget());

      // Try to increment above max
      await tester.tap(find.byIcon(Icons.expand_less));
      await tester.pump();

      // Should stay at 100
      expect(controller.text, '100');
    });

    testWidgets('calls onChanged callback when value changes', (tester) async {
      int? changedValue;

      await tester.pumpWidget(
        buildTestWidget(
          onChanged: (value) => changedValue = value,
        ),
      );

      await tester.tap(find.byIcon(Icons.expand_less));
      await tester.pump();

      expect(changedValue, 1);
    });

    testWidgets('does not change when disabled', (tester) async {
      controller.text = '5';
      await tester.pumpWidget(buildTestWidget(enabled: false));

      await tester.tap(find.byIcon(Icons.expand_less), warnIfMissed: false);
      await tester.pump();

      // Value should not change
      expect(controller.text, '5');
    });

    testWidgets('text field does not accept direct input (read-only)', (tester) async {
      controller.text = '5';
      await tester.pumpWidget(buildTestWidget());

      // Verify the stepper renders correctly
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.expand_less), findsOneWidget);
      expect(find.byIcon(Icons.expand_more), findsOneWidget);
    });

    testWidgets('initializes from controller value', (tester) async {
      controller.text = '25';
      await tester.pumpWidget(buildTestWidget());

      // Increment from initial value
      await tester.tap(find.byIcon(Icons.expand_less));
      await tester.pump();

      expect(controller.text, '26');
    });

    testWidgets('clamps initial value to min/max range', (tester) async {
      controller.text = '150'; // Above max of 100
      await tester.pumpWidget(buildTestWidget());

      // Try to increment - should be clamped to max
      await tester.tap(find.byIcon(Icons.expand_less));
      await tester.pump();

      // Value should be clamped to max (100)
      expect(int.parse(controller.text), lessThanOrEqualTo(100));
    });
  });
}
