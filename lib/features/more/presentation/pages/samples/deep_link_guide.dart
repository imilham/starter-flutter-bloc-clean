import 'package:flutter/material.dart';
import 'package:starter/features/more/presentation/pages/samples/sample_section.dart';
import 'package:starter/utils/utils.dart';

class DeepLinkGuide extends StatelessWidget {
  const DeepLinkGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Deep Linking',
          style: context.textTheme.headlineMedium,
        ),
        Gap.small8,
        Text(
          'Handle incoming URLs to navigate to specific screens in your app.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Gap.medium16,
        const _InfoBanner(),
        Gap.medium16,
        const Divider(),
        Gap.medium16,
        Text(
          'Developer Guide',
          style: context.textTheme.titleLarge,
        ),
        Gap.medium16,
        const SampleSection(
          title: 'Android Setup',
          icon: Icons.android,
          children: [
            _StepItem(
              step: '1',
              title: 'AndroidManifest.xml',
              description: 'Add this intent-filter inside your <activity> tag in `android/app/src/main/AndroidManifest.xml`.',
              code: '''
<!-- Deep Linking -->
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <!-- Accepts URIs that begin with "https://www.example.com/gizmos” -->
    <data android:scheme="https"
          android:host="www.example.com"
          android:pathPrefix="/gizmos" />
    <!-- Also accept "customscheme://*" -->
    <data android:scheme="customscheme" />
</intent-filter>''',
            ),
          ],
        ),
        const SampleSection(
          title: 'iOS Setup',
          icon: Icons.apple,
          children: [
            _StepItem(
              step: '2',
              title: 'Info.plist',
              description: 'Add `FlutterDeepLinkingEnabled` to `ios/Runner/Info.plist`.',
              code: '''
<key>FlutterDeepLinkingEnabled</key>
<true/>
<key>CFBundleURLTypes</key>
<array>
    <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLName</key>
    <string>example.com</string>
    <key>CFBundleURLSchemes</key>
    <array>
    <string>customscheme</string>
    </array>
    </dict>
</array>''',
            ),
          ],
        ),
         const SampleSection(
          title: 'Flutter Setup',
          icon: Icons.flutter_dash,
          children: [
            _StepItem(
              step: '3',
              title: 'GoRouter Config',
              description: 'GoRouter handles deep links automatically if configured.',
              code: '''
final router = GoRouter(
  routes: [
    GoRoute(
      path: 'details/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return DetailsPage(id: id);
      },
    ),
  ],
);''',
            ),
          ],
        ),
        const SampleSection(
          title: 'Testing',
          icon: Icons.terminal,
          children: [
            _StepItem(
              step: '4',
              title: 'Test on Android',
              description: 'Run this command in your terminal.',
              code: 'adb shell am start -W -a android.intent.action.VIEW -d "customscheme://details/123" com.example.starter',
            ),
             _StepItem(
              step: '5',
              title: 'Test on iOS',
              description: 'Run this command in your terminal.',
              code: 'xcrun simctl openurl booted "customscheme://details/123"',
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info, color: context.colorScheme.primary),
          Gap.medium16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Documentation Only',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
                Gap.small8,
                  Text(
                  'This feature requires native configuration. Follow the steps below to enable it in your app.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  const _StepItem({
    required this.step,
    required this.title,
    required this.description,
    this.code,
  });

  final String step;
  final String title;
  final String description;
  final String? code;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colorScheme.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Text(
              step,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Gap.medium16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (code != null) ...[
                  Gap.small8,
                  _CodeSnippet(code: code!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  const _CodeSnippet({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colorScheme.outlineVariant,
        ),
      ),
      child: SelectableText(
        code,
        style: TextStyle(
          fontFamily: 'Courier',
          fontSize: 12,
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
