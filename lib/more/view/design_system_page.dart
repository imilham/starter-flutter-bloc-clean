import 'package:flutter/material.dart';
import 'package:starter/app/app.dart';

import 'package:starter/utils/utils.dart';

class DesignSystemPage extends StatelessWidget {
  const DesignSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CommonAppBar(
          title: 'Design System',
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Styles'),
              Tab(text: 'Components'),
              Tab(text: 'Overlays'),
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
            _StylesTab(),
            _ComponentsTab(),
            _OverlaysTab(),
          ],
        ),
      ),
    );
  }
}

class _StylesTab extends StatelessWidget {
  const _StylesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionHeader.large('Colors'),
        const Text('Material Color Scheme'),
        Gap.small8,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _ColorChip(name: 'Primary', color: context.colorScheme.primary),
            _ColorChip(name: 'Secondary', color: context.colorScheme.secondary),
            _ColorChip(name: 'Surface', color: context.colorScheme.surface),
            _ColorChip(name: 'Error', color: context.colorScheme.error),
          ],
        ),
        Gap.large24,
        const Text('Custom App Colors (ThemeExtension)'),
        Gap.small8,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _ColorChip(
              name: 'Shimmer',
              color: context.appColors.shimmerColor,
            ),
            _ColorChip(
              name: 'Shimmer BG',
              color: context.appColors.shimmerBgColor,
            ),
          ],
        ),
        const Divider(height: 32),
        const SectionHeader.large('Typography'),
        _TypeSample(style: context.displaySmall, name: 'Display Small'),
        _TypeSample(style: context.headlineMedium, name: 'Headline Medium'),
        _TypeSample(style: context.headlineSmall, name: 'Headline Small'),
        _TypeSample(style: context.titleMedium, name: 'Title Medium'),
        const Divider(),
        _TypeSample(style: context.bodyLarge, name: 'Body Large'),
        _TypeSample(style: context.bodyLarge?.bold, name: 'Body Large Bold'),
        Gap.small8,
        _TypeSample(style: context.bodyMedium, name: 'Body Medium'),
        _TypeSample(style: context.bodyMedium?.bold, name: 'Body Medium Bold'),
        Gap.small8,
        _TypeSample(style: context.bodySmall, name: 'Body Small'),
        _TypeSample(style: context.bodySmall?.bold, name: 'Body Small Bold'),
        Gap.small8,
        _TypeSample(style: context.labelSmall, name: 'Label Small'),
      ],
    );
  }
}

class _ComponentsTab extends StatefulWidget {
  const _ComponentsTab();

  @override
  State<_ComponentsTab> createState() => _ComponentsTabState();
}

class _ComponentsTabState extends State<_ComponentsTab> {
  final TextEditingController _simpleController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    _simpleController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionHeader.large('Buttons'),
        CommonElevatedButton(
          text: 'Primary Button',
          onPressed: () {},
        ),
        Gap.small8,
        CommonElevatedButton(
          text: 'Loading Button',
          isLoading: true,
          onPressed: () {},
        ),
        Gap.small8,
        const CommonElevatedButton(
          text: 'Disabled Button',
        ),
        Gap.medium16,
        CommonOutlineButton(
          text: 'Outline Button',
          onPressed: () {},
        ),
        const Divider(height: 32),
        const SectionHeader.large('Loader'),
        const Center(child: CommonCircularLoader.custom(size: 32)),
        const Divider(height: 32),
        const SectionHeader.large('Carousel'),
        CommonCarousel.images(
          imageUrls: const [
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
            'https://images.unsplash.com/photo-1469474968028-56623f02e42e',
          ],
          height: 150,
        ),
        const Divider(height: 32),
        const SectionHeader.large('Inputs'),
        CommonBaseTextField(
          controller: _simpleController,
          title: 'Simple Input',
          hintText: 'Type something...',
        ),
        Gap.medium16,
        PasswordFormField(
          controller: _passController,
          title: 'Password Input',
          hintText: 'Password',
        ),
      ],
    );
  }
}

class _OverlaysTab extends StatelessWidget {
  const _OverlaysTab();

  @override
  Widget build(BuildContext context) {
    return ExtendedColumn(
      children: [
        const SectionHeader.large('Dialogs'),
        CommonElevatedButton(
          text: 'Show Alert Dialog',
          onPressed: () {
            CommonDialog.alert(
              context,
              title: 'This is an Alert',
              message: 'Here is some important information for the user.',
            );
          },
        ),
        Gap.medium16,
        CommonElevatedButton(
          text: 'Show Confirm Dialog',
          onPressed: () {
            CommonDialog.confirm(
              context,
              title: 'Are you sure?',
              message: 'This action cannot be undone.',
              isDangerous: true,
            );
          },
        ),
        Gap.large24,
        const SectionHeader.large('Bottom Sheet'),
        CommonElevatedButton(
          text: 'Show Bottom Sheet',
          onPressed: () {
            CommonBottomSheet.show<void>(
              context,
              title: 'My Bottom Sheet',
              child: Container(
                height: 200,
                alignment: Alignment.center,
                child: const Text('Sheet Content Goes Here'),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ColorChip extends StatelessWidget {
  const _ColorChip({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
        ),
        Gap.extraSmall4,
        Text(name, style: context.labelSmall),
      ],
    );
  }
}

class _TypeSample extends StatelessWidget {
  const _TypeSample({required this.style, required this.name});

  final TextStyle? style;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.bodySmall?.copyWith(color: Colors.grey.shade600),
                ),
                Text(
                  '${style?.fontSize?.toStringAsFixed(0)}sp',
                  style: context.labelSmall?.copyWith(color: Colors.grey.shade400),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Quick Brown Fox',
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
