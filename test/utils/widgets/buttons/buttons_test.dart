// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:starter/utils/widgets/buttons/buttons.dart';

// void main() {
//   group('CommonElevatedButton', () {
//     testWidgets('renders with required parameters', (tester) async {
//       await tester.pumpWidget(
//         const MaterialApp(
//           home: Scaffold(
//             body: CommonButton.primary(
//               text: 'Test Button',
//             ),
//           ),
//         ),
//       );

//       expect(find.text('Test Button'), findsOneWidget);
//       expect(find.byType(ElevatedButton), findsOneWidget);
//     });

//     testWidgets('calls onPressed when tapped', (tester) async {
//       var pressed = false;

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: CommonButton.primary(
//               text: 'Test',
//               onPressed: () => pressed = true,
//             ),
//           ),
//         ),
//       );

//       await tester.tap(find.byType(CommonElevatedButton));
//       await tester.pump();

//       expect(pressed, isTrue);
//     });

//     testWidgets('shows loading spinner when isLoading is true', (tester) async {
//       await tester.pumpWidget(
//         const MaterialApp(
//           home: Scaffold(
//             body: CommonButton.primary(
//               text: 'Test',
//               isLoading: true,
//             ),
//           ),
//         ),
//       );

//       expect(find.byType(CircularProgressIndicator), findsOneWidget);
//       expect(find.text('Test'), findsNothing);
//     });

//     testWidgets('disables button when isLoading is true', (tester) async {
//       var pressed = false;

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: CommonButton.primary(
//               text: 'Test',
//               isLoading: true,
//               onPressed: () => pressed = true,
//             ),
//           ),
//         ),
//       );

//       await tester.tap(find.byType(CommonElevatedButton));
//       await tester.pump();

//       expect(pressed, isFalse);
//     });

//     testWidgets('displays icon when provided', (tester) async {
//       await tester.pumpWidget(
//         const MaterialApp(
//           home: Scaffold(
//             body: CommonButton.primary(
//               text: 'Save',
//               icon: Icons.save,
//             ),
//           ),
//         ),
//       );

//       expect(find.byIcon(Icons.save), findsOneWidget);
//       expect(find.text('Save'), findsOneWidget);
//     });

//     testWidgets('large button expands to full width', (tester) async {
//       await tester.pumpWidget(
//         const MaterialApp(
//           home: Scaffold(
//             body: CommonButton.primary(
//               text: 'Test',
//             ),
//           ),
//         ),
//       );

//       final sizedBox = tester.widget<SizedBox>(
//         find
//             .ancestor(
//               of: find.byType(ElevatedButton),
//               matching: find.byType(SizedBox),
//             )
//             .first,
//       );
//       expect(sizedBox.width, double.infinity);
//     });

//     testWidgets('small factory creates small button', (tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: CommonElevatedButton.small(
//               text: 'Small',
//               onPressed: () {},
//             ),
//           ),
//         ),
//       );

//       expect(find.text('Small'), findsOneWidget);
//     });
//   });

//   group('CommonSecondaryButton', () {
//     testWidgets('renders with required parameters', (tester) async {
//       await tester.pumpWidget(
//         const MaterialApp(
//           home: Scaffold(
//             body: CommonOutlineButton(
//               text: 'Cancel',
//             ),
//           ),
//         ),
//       );

//       expect(find.text('Cancel'), findsOneWidget);
//       expect(find.byType(OutlinedButton), findsOneWidget);
//     });

//     testWidgets('shows loading spinner when isLoading is true', (tester) async {
//       await tester.pumpWidget(
//         const MaterialApp(
//           home: Scaffold(
//             body: CommonOutlineButton(
//               text: 'Cancel',
//               isLoading: true,
//             ),
//           ),
//         ),
//       );

//       expect(find.byType(CircularProgressIndicator), findsOneWidget);
//       expect(find.text('Cancel'), findsNothing);
//     });

//     testWidgets('calls onPressed when tapped', (tester) async {
//       var pressed = false;

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: CommonOutlineButton(
//               text: 'Cancel',
//               onPressed: () => pressed = true,
//             ),
//           ),
//         ),
//       );

//       await tester.tap(find.byType(CommonOutlineButton));
//       await tester.pump();

//       expect(pressed, isTrue);
//     });

//     testWidgets('small factory creates small button', (tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: CommonOutlineButton.small(
//               text: 'Small',
//               onPressed: () {},
//             ),
//           ),
//         ),
//       );

//       expect(find.text('Small'), findsOneWidget);
//     });
//   });

//   group('ButtonSize enum', () {
//     test('has correct values', () {
//       expect(ButtonSize.values.length, 2);
//       expect(ButtonSize.small, isNotNull);
//       expect(ButtonSize.large, isNotNull);
//     });
//   });

//   group('IconPosition enum', () {
//     test('has correct values', () {
//       expect(IconPosition.values.length, 2);
//       expect(IconPosition.leading, isNotNull);
//       expect(IconPosition.trailing, isNotNull);
//     });
//   });
// }
