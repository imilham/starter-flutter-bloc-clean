import 'package:flutter/material.dart';
import 'package:starter/app/app.dart';
import 'package:starter/more/view/samples/samples.dart';
import 'package:starter/utils/utils.dart';

// TODO: remove-samples-im

class DesignSystemPage extends StatelessWidget {
  const DesignSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CommonAppBar(
          title: 'Design System',
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Styles'),
              Tab(text: 'Components'),
              Tab(text: 'Overlays'),
              Tab(text: 'Performance'),
              Tab(text: 'Concurrency'),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Switch(
                value: context.watch<ThemeServiceProvider>().isDark,
                onChanged: (value) {
                  context.read<ThemeServiceProvider>().toggleTheme();
                },
              ),
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            StylesSample(),
            ComponentsSample(),
            OverlaysSample(),
            PerformanceSample(),
            IsolateSample(),
          ],
        ),
      ),
    );
  }
}
