import 'package:flutter/material.dart';
import 'package:starter/app/app.dart';
import 'package:starter/more/view/samples/localization_sample.dart';
import 'package:starter/more/view/samples/samples.dart';
import 'package:starter/utils/utils.dart';

// TODO: remove-samples-im

class DesignSystemPage extends StatelessWidget {
  const DesignSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12,
      child: Scaffold(
        appBar: CommonAppBar(
          title: 'Design System',
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(text: 'Styles'),
              Tab(text: 'Extensions'),
              Tab(text: 'Components'),
              Tab(text: 'Shimmer'),
              Tab(text: 'Overlays'),
              Tab(text: 'Performance'),
              Tab(text: 'Concurrency'),
              Tab(text: 'Biometrics'),
              Tab(text: 'Localization'),
              Tab(text: 'PDF Generation'),
              Tab(text: 'App Sharing'),
              Tab(text: 'Deep Links'),
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
            ExtensionsSample(),
            ComponentsSample(),
            ShimmerSample(),
            OverlaysSample(),
            PerformanceSample(),
            IsolateSample(),
            BiometricSample(),
            LocalizationSample(),
            PdfGuide(),
            ShareGuide(),
            DeepLinkGuide(),
          ],
        ),
      ),
    );
  }
}
