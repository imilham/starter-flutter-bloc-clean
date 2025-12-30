import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/utils/widgets/common_stream_builder.dart';

// Test state classes
abstract class TestState {}

class TestLoading extends TestState {}

class TestError extends TestState {
  TestError(this.message);
  final String message;
}

class TestSuccess extends TestState {
  TestSuccess(this.data);
  final String data;
}

void main() {
  group('CommonStreamBuilder', () {
    testWidgets('shows loading widget initially', (tester) async {
      final controller = StreamController<TestState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonStreamBuilder<TestState>(
              stream: controller.stream,
              loading: const Text('Loading...'),
              builder: (state) => Text('Success: ${(state as TestSuccess).data}'),
            ),
          ),
        ),
      );

      expect(find.text('Loading...'), findsOneWidget);

      controller.close();
    });

    testWidgets('shows loading when state is Loading type', (tester) async {
      final controller = StreamController<TestState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonStreamBuilder<TestState>(
              stream: controller.stream,
              initialData: TestLoading(),
              loading: const Text('Loading...'),
              builder: (state) => const Text('Success'),
            ),
          ),
        ),
      );

      expect(find.text('Loading...'), findsOneWidget);

      await controller.close();
    });

    testWidgets('shows success content when state is success', (tester) async {
      final controller = StreamController<TestState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonStreamBuilder<TestState>(
              stream: controller.stream,
              loading: const Text('Loading...'),
              builder: (state) => Text('Data: ${(state as TestSuccess).data}'),
            ),
          ),
        ),
      );

      controller.add(TestSuccess('Hello'));
      await tester.pump();

      expect(find.text('Data: Hello'), findsOneWidget);

      controller.close();
    });

    testWidgets('shows error widget when state is Error type', (tester) async {
      final controller = StreamController<TestState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonStreamBuilder<TestState>(
              stream: controller.stream,
              loading: const Text('Loading...'),
              error: (state) => Text('Error: ${(state as TestError).message}'),
              builder: (state) => const Text('Success'),
            ),
          ),
        ),
      );

      controller.add(TestError('Something went wrong'));
      await tester.pump();

      expect(find.text('Error: Something went wrong'), findsOneWidget);

      controller.close();
    });

    testWidgets('uses custom isLoading function', (tester) async {
      final controller = StreamController<String>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonStreamBuilder<String>(
              stream: controller.stream,
              isLoading: (state) => state == 'loading',
              loading: const Text('Custom Loading...'),
              builder: (state) => Text('Data: $state'),
            ),
          ),
        ),
      );

      controller.add('loading');
      await tester.pump();

      expect(find.text('Custom Loading...'), findsOneWidget);

      controller.close();
    });
  });
}
