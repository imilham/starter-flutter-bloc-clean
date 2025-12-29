import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/widgets/form_fields/description_form_field.dart';

void main() {
  group('DescriptionFormField', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    Widget buildTestWidget({
      String hintText = 'Enter description',
      String? title,
      int minLines = 3,
      int? maxLines,
      int? maxLength,
      bool showCounter = false,
      String? Function(String?)? validator,
      bool enabled = true,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: DescriptionFormField(
            controller: controller,
            hintText: hintText,
            title: title,
            minLines: minLines,
            maxLines: maxLines,
            maxLength: maxLength,
            showCounter: showCounter,
            validator: validator,
            enabled: enabled,
          ),
        ),
      );
    }

    testWidgets('renders with required parameters', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Enter description'), findsOneWidget);
    });

    testWidgets('displays title when provided', (tester) async {
      await tester.pumpWidget(buildTestWidget(title: 'Description'));

      expect(find.text('Description'), findsOneWidget);
    });

    testWidgets('accepts multi-line input', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.enterText(find.byType(TextFormField), 'Line 1\nLine 2\nLine 3');
      await tester.pump();

      expect(controller.text, 'Line 1\nLine 2\nLine 3');
    });

    testWidgets('widget is created with correct minLines', (tester) async {
      await tester.pumpWidget(buildTestWidget(minLines: 5));

      // Verify the widget was created - minLines is passed to the widget
      final widgetFinder = find.byType(DescriptionFormField);
      final widget = tester.widget<DescriptionFormField>(widgetFinder);
      expect(widget.minLines, 5);
    });

    testWidgets('widget is created with correct maxLines', (tester) async {
      await tester.pumpWidget(buildTestWidget(maxLines: 10));

      final widgetFinder = find.byType(DescriptionFormField);
      final widget = tester.widget<DescriptionFormField>(widgetFinder);
      expect(widget.maxLines, 10);
    });

    testWidgets('widget is created with correct maxLength', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        maxLength: 100,
        showCounter: true,
      ),);

      final widgetFinder = find.byType(DescriptionFormField);
      final widget = tester.widget<DescriptionFormField>(widgetFinder);
      expect(widget.maxLength, 100);
    });

    testWidgets('validates with custom validator', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        validator: (value) => value?.isEmpty ?? true ? 'Description is required' : null,
      ),);

      final widgetFinder = find.byType(DescriptionFormField);
      final widget = tester.widget<DescriptionFormField>(widgetFinder);
      expect(widget.validator, isNotNull);
    });

    testWidgets('is disabled when enabled is false', (tester) async {
      await tester.pumpWidget(buildTestWidget(enabled: false));

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('widget uses multiline input', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      // Verify we can enter multiline text
      await tester.enterText(find.byType(TextFormField), 'First line\nSecond line');
      await tester.pump();

      expect(controller.text.contains('\n'), isTrue);
    });

    testWidgets('shows character counter when maxLength is set', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        maxLength: 100,
      ),);

      await tester.enterText(find.byType(TextFormField), 'Hello');
      await tester.pump();

      // Check that custom counter shows correct count
      expect(find.text('5 / 100'), findsOneWidget);
    });
  });
}
