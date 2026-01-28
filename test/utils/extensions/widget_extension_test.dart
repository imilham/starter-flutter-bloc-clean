
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/extensions/widget_extension.dart';

void main() {
  group('Widget Padding Extension', () {
    testWidgets('paddingAll16 applies correct padding', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: const Text('Test').paddingAll16,
        ),
      );

      final paddingFinder = find.byType(Padding);
      expect(paddingFinder, findsOneWidget);

      final padding = tester.widget<Padding>(paddingFinder);
      expect(padding.padding, const EdgeInsets.all(16));
    });

    testWidgets('paddingHorizontal8 applies correct horizontal padding', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: const Text('Test').paddingHorizontal8,
        ),
      );

      final paddingFinder = find.byType(Padding);
      final padding = tester.widget<Padding>(paddingFinder);
      expect(padding.padding, const EdgeInsets.symmetric(horizontal: 8));
    });
  });

  group('Widget Margin Extension', () {
    testWidgets('marginAll8 applies correct margin using Padding', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: const Text('Test').marginAll8,
        ),
      );

      final paddingFinder = find.byType(Padding);
      // Margin extension uses Padding internally for better performance
      expect(paddingFinder, findsOneWidget);

      final padding = tester.widget<Padding>(paddingFinder);
      expect(padding.padding, const EdgeInsets.all(8));
    });
  });

  group('Widget Box Extension', () {
    testWidgets('box applies correct decoration', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: const Text('Test').box(color: Colors.red, radius: 10),
        ),
      );

      final decoratedBoxFinder = find.byType(DecoratedBox);
      expect(decoratedBoxFinder, findsOneWidget);

      final decoratedBox = tester.widget<DecoratedBox>(decoratedBoxFinder);
      final decoration = decoratedBox.decoration as BoxDecoration;
      
      expect(decoration.color, Colors.red);
      expect(decoration.borderRadius, BorderRadius.circular(10));
    });
  });
  
  group('Widget Visibility Extension', () {
     // Assuming there might be visibility extensions, if not, skip.
     // Checking file... there is no visibility extension in the previous view_file output.
     // There are gesture extensions though.
  });

  group('Widget Gesture Extension', () {
     testWidgets('onTap triggers callback', (tester) async {
       var tapped = false;
       await tester.pumpWidget(
         Directionality(
           textDirection: TextDirection.ltr,
           child: const Text('Tap Me').onTap(() {
             tapped = true;
           }),
         ),
       );

       await tester.tap(find.text('Tap Me'));
       expect(tapped, true);
     });
  });
}
