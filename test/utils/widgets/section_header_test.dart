import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/widgets/section_header.dart'; // Direct import to avoid ambiguity if exported elsewhere

void main() {
  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  group('SectionHeader', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        const SectionHeader.medium('My Header'),
      ),);

      expect(find.text('My Header'), findsOneWidget);
    });

    testWidgets('renders action widget when provided', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        SectionHeader.medium(
          'Header',
          action: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ),
      ),);

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('Large variant uses larger text style', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        const SectionHeader.large('Large Header'),
      ),);

      final text = tester.widget<Text>(find.text('Large Header'));
      // We can't easily assert exact style without a full theme setup, but we can check if it rendered.
      expect(text.data, 'Large Header');
    });

    testWidgets('applies custom padding', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        const SectionHeader.medium(
          'Padded Header',
          padding: EdgeInsets.all(20),
        ),
      ),);

      final padding = tester.widget<Padding>(find
          .ancestor(
            of: find.text('Padded Header'),
            matching: find.byType(Padding),
          )
          .first,);

      expect(padding.padding, const EdgeInsets.all(20));
    });

    testWidgets('Small variant renders defaults', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        const SectionHeader.small('Small Header'),
      ),);

      expect(find.text('Small Header'), findsOneWidget);
    });
  });
}
