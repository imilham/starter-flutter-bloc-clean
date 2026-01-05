import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

// TODO: remove-samples-im

class IsolateSample extends StatefulWidget {
  const IsolateSample({super.key});

  @override
  State<IsolateSample> createState() => _IsolateSampleState();
}

class _IsolateSampleState extends State<IsolateSample> {
  bool _isProcessing = false;
  String _result = 'No result yet';
  int _counter = 0;

  // Simulate a heavy task (e.g., parsing large JSON, image processing)
  static int _heavyTask(int count) {
    var sum = 0;
    for (var i = 0; i < count; i++) {
      sum += i;
    }
    return sum;
  }

  Future<void> _runHeavyTaskMainThread() async {
    if (mounted) {
      setState(() {
        _isProcessing = true;
        _result = 'Processing on Main Thread... (UI will freeze)';
      });
    }

    // Force a frame to process so the loader appears before we freeze everything
    await Future<void>.delayed(const Duration(milliseconds: 100));

    // Blocking the main thread
    final stopwatch = Stopwatch()..start();
    final sum = _heavyTask(4000000000); // Extremely heavy loop (approx 2-4s)
    stopwatch.stop();

    if (mounted) {
      setState(() {
        _isProcessing = false;
        _result = 'Main Thread Result: $sum\nTime: ${stopwatch.elapsedMilliseconds}ms\n(Did you see the loader freeze?)';
      });
    }
  }

  Future<void> _runHeavyTaskIsolate() async {
    setState(() {
      _isProcessing = true;
      _result = 'Processing in Isolate... (UI remains responsive)';
    });

    final stopwatch = Stopwatch()..start();

    // Spawning a worker isolate
    // compute() is a helper wrapper around Isolate.spawn
    // but here we can use Isolate.run for Flutter 3.7+
    final sum = await Isolate.run(() => _heavyTask(4000000000));

    stopwatch.stop();

    if (mounted) {
      setState(() {
        _isProcessing = false;
        _result = 'Isolate Result: $sum\nTime: ${stopwatch.elapsedMilliseconds}ms';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionHeader.large('Concurrency: Isolates'),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The Engineering Trick: Isolates',
                style: context.titleMedium?.bold,
              ),
              Gap.small8,
              const Text(
                'Dart is single-threaded. Heavy calculations (like parsing huge JSON or filtering lists) block the UI thread, causing "jank" (dropped frames).\n\n'
                'Isolates allow you to run code in a separate thread memory space. The UI stays buttery smooth while the heavy lifting happens in the background.',
              ),
            ],
          ),
        ),
        Gap.large24,

        // JANK DEMO UI
        const SectionHeader.large('Live Demo: UI Freeze Test'),
        const Text('Tap the counter button repeatedly while running tasks. If the counter stops updating, the UI is frozen.'),
        Gap.medium16,

        Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$_counter',
              style: context.headlineMedium?.copyWith(
                color: context.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Gap.small8,
        Center(
          child: CommonElevatedButton(
            text: 'Tap Me! (Test Responsiveness)',
            onPressed: () => setState(() => _counter++),
          ),
        ),

        Gap.large24,
        const Divider(),
        Gap.medium16,

        // CONTROLS
        Row(
          children: [
            Expanded(
              child: CommonElevatedButton(
                text: 'Run on Main Thread',
                // Using error color to indicate this is "bad" practice for heavy tasks
                backgroundColor: context.colorScheme.error,
                foregroundColor: context.colorScheme.onError,
                isLoading: _isProcessing,
                onPressed: _isProcessing ? null : _runHeavyTaskMainThread,
              ),
            ),
            Gap.medium16,
            Expanded(
              child: CommonElevatedButton(
                text: 'Run in Isolate',
                // Using primary color for "good" practice
                isLoading: _isProcessing,
                onPressed: _isProcessing ? null : _runHeavyTaskIsolate,
              ),
            ),
          ],
        ),

        Gap.large24,

        // RESULT DISPLAY
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.colorScheme.outline),
          ),
          child: Column(
            children: [
              Text('Status / Result', style: context.labelLarge),
              Gap.small8,
              Text(
                _result,
                textAlign: TextAlign.center,
                style: context.bodyMedium?.copyWith(
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),

        Gap.large24,
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            '// Code Example (Flutter 3.7+)\n'
            'final result = await Isolate.run(() {\n'
            '  return heavyComputation();\n'
            '});',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
      ],
    );
  }
}
