import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

// TODO: remove-samples-im

class PerformanceSample extends StatefulWidget {
  const PerformanceSample({super.key});

  @override
  State<PerformanceSample> createState() => _PerformanceSampleState();
}

class _PerformanceSampleState extends State<PerformanceSample> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionHeader.large('Performance Optimization'),
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
                'The Engineering Trick: RepaintBoundary',
                style: bodyRegular(
                  fontWeight: FontWeight.bold,
                  textColor: context.colorScheme.onSurfaceVariant,
                ),
              ),
              Gap.small8,
              Text(
                'By default, if one small icon animates, Flutter might repaint the entire screen. '
                'By wrapping that icon in a RepaintBoundary, you create a separate "layer." '
                'Now, Flutter only repaints that small area, saving massive amounts of GPU power.',
                style: bodySmall(
                  textColor: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Gap.large24,
        const SectionHeader.large('Live Demo'),
        Text(
          'To verify optimization:\n'
          '1. Open Flutter DevTools (cmd + shift + p -> Open DevTools)\n'
          '2. Go to "Performance" or "Inspector" tab\n'
          '3. Enable "Highlight Repaints" (Rainbow icon)\n'
          '4. Without RepaintBoundary, the whole list might flash.\n'
          '5. With RepaintBoundary, ONLY the logo flashes.',
          style: bodySmall(height: 1.5),
        ),
        Gap.medium16,
        Center(
          child: RepaintBoundary(
            child: RotationTransition(
              turns: _controller,
              child: const FlutterLogo(size: 80),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '// Code Example\n'
            'RepaintBoundary(\n'
            '  child: RotationTransition(\n'
            '    turns: _controller,\n'
            '    child: FlutterLogo(),\n'
            '  ),\n'
            ')',
            style: bodyXSmall().copyWith(fontFamily: 'monospace'),
          ),
        ),
      ],
    );
  }
}
