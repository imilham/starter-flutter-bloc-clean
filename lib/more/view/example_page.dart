import 'package:flutter/material.dart';
import 'package:starter/app/app.dart';
import 'package:starter/utils/utils.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  static const String routeName = 'example';

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Playground')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Carousel Demos'),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: GetIt.instance<ThemeServiceProvider>().isDark,
              onChanged: (value) {
                GetIt.instance<ThemeServiceProvider>().toggleTheme();
              },
            ),
            const SizedBox(height: 16),
            const Text('Standard Image Carousel:'),
            const SizedBox(height: 8),
            CommonCarousel.images(
              imageUrls: const [
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                'https://images.unsplash.com/photo-1469474968028-56623f02e42e',
              ],
              height: 180,
              indicatorActiveColor: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            const Text('Custom Widget Carousel:'),
            const SizedBox(height: 8),
            CommonCarousel(
              height: 120,
              items: [
                ColoredBox(
                  color: Colors.orange.shade100,
                  child: const Center(child: Text('Custom 1')),
                ),
                ColoredBox(
                  color: Colors.purple.shade100,
                  child: const Center(child: Text('Custom 2')),
                ),
              ],
              indicatorBuilder: (BuildContext context, int index, bool isActive) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    isActive ? Icons.circle : Icons.circle_outlined,
                    color: isActive ? Colors.purple : Colors.grey,
                    size: 16,
                  ),
                );
              },
            ),

            const Divider(height: 48),
            _buildSectionHeader('App Colors (ThemeExtension)'),
            // TODO(ilham): Remove this section later when real implementation is ready and colors are standardized
            Row(
              children: [
                Expanded(
                  child: _ColorSample(
                    name: 'Shimmer Color',
                    color: context.appColors.shimmerColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ColorSample(
                    name: 'Shimmer BG',
                    color: context.appColors.shimmerBgColor,
                  ),
                ),
              ],
            ),

            const Divider(height: 48),
            _buildSectionHeader('Overlays & Feedback'),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                CommonElevatedButton(
                  onPressed: () {
                    CommonDialog.alert(
                      context,
                      title: 'Alert',
                      message: 'This is a standard alert dialog.',
                    );
                  },
                  text: 'Show Alert',
                ),
                CommonElevatedButton(
                  onPressed: () {
                    CommonDialog.confirm(
                      context,
                      title: 'Confirm',
                      message: 'Do you want to proceed?',
                      isDangerous: true,
                    );
                  },
                  text: 'Show Confirm',
                ),
                CommonElevatedButton(
                  onPressed: () {
                    CommonBottomSheet.show<void>(
                      context,
                      title: 'Bottom Sheet',
                      child: Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: const Text('This is a bottom sheet content'),
                      ),
                    );
                  },
                  text: 'Show Sheet',
                ),
              ],
            ),

            const Divider(height: 48),
            _buildSectionHeader('Buttons'),
            CommonElevatedButton(
              onPressed: () {},
              text: 'Primary Button',
            ),
            const SizedBox(height: 16),
            CommonOutlineButton(
              onPressed: () {},
              text: 'Outline Button',
            ),

            const Divider(height: 48),
            _buildSectionHeader('Input Fields'),
            CommonBaseTextField(
              controller: _emailController,
              hintText: 'Enter text...',
              title: 'Common Text Field',
            ),
            const SizedBox(height: 16),
            EmailFormField(
              controller: _emailController,
              title: 'Email Address',
            ),
            const SizedBox(height: 16),
            PasswordFormField(
              controller: _passwordController,
              title: 'Password',
              hintText: 'Enter password',
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class _ColorSample extends StatelessWidget {
  const _ColorSample({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
