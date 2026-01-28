import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/extensions/overlay_extension.dart';

void main() {
  testWidgets('AnchoredOverlay shows and hides overlay', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Builder(
              builder: (context) {
                return const Text('Target').anchored(
                  overlayBuilder: (context, hide) => const Text('Overlay Content'),
                );
              },
            ),
          ),
        ),
      ),
    );

    // Initial state: Overlay not visible
    expect(find.text('Overlay Content'), findsNothing);

    // Tap target to show overlay
    await tester.tap(find.text('Target'));
    await tester.pump(); // Trigger rebuilding

    // Overlay should be visible
    expect(find.text('Overlay Content'), findsOneWidget);

    // Tap target again to hide overlay (since we implemented toggle in AnchoredOverlay)
    await tester.tap(find.text('Target'));
    await tester.pump();

    // Overlay should be hidden
    expect(find.text('Overlay Content'), findsNothing);
  });
}
