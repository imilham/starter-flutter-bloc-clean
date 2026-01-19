import 'package:flutter/material.dart';
import 'package:starter/more/view/samples/sample_section.dart';
import 'package:starter/utils/utils.dart';

// TODO: remove-samples-im

class ComponentsSample extends StatefulWidget {
  const ComponentsSample({super.key});

  @override
  State<ComponentsSample> createState() => _ComponentsSampleState();
}

class _ComponentsSampleState extends State<ComponentsSample> {
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
    final date = DateTime.now();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'UI Components',
          style: context.textTheme.headlineMedium,
        ),
        Gap.small8,
        Text(
          'Reusable widgets and form elements.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Gap.medium16,
        SampleSection(
          title: 'Buttons',
          icon: Icons.smart_button,
          isExpanded: true,
          children: [
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
            Gap.small8,
            CommonElevatedButton(
              text: 'Fixed Width (120)',
              width: 120,
              onPressed: () {},
            ),
            Gap.small8,
            Row(
              children: [
                Expanded(
                  child: CommonElevatedButton.small(
                    text: 'Small Button',
                    onPressed: () {},
                  ),
                ),
                Gap.small8,
                Expanded(
                  child: CommonOutlineButton.small(
                    text: 'Small Outline',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
        SampleSection(
          title: 'Carousel',
          icon: Icons.view_carousel,
          children: [
            CommonCarousel.images(
              imageUrls: const [
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                'https://images.unsplash.com/photo-1469474968028-56623f02e42e',
              ],
              height: 150,
            ),
          ],
        ),
        SampleSection(
          title: 'Inputs',
          icon: Icons.input,
          children: [
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
            Gap.medium16,
            CommonBaseTextField(
              controller: TextEditingController(),
              title: 'Read Only Input',
              hintText: 'Cannot edit this',
              readOnly: true,
            ),
          ],
        ),
        SampleSection(
          title: 'Date Utilities',
          icon: Icons.calendar_today,
          children: [
            Text(
              'Original: 06/01/2026',
              style: bodyRegular16(
                fontWeight: FontWeight.w200,
                fontStyle: FontStyle.italic,
              ),
            ),
            Gap.small8,
            Text(
              date.format('dd MMM yyyy'),
              style: headline20(textColor: context.colorScheme.primary),
            ),
            Gap.large24,
            Text(
              'String Date Parsing & Formatting:',
              style: bodySmall14(fontWeight: FontWeight.bold),
            ),
            Gap.small8,
            Text(
              '2026-01-06T12:00:00'.formatDate('MMMM dd, yyyy'),
              style: bodyRegular16(textColor: context.colorScheme.primary),
            ),
          ],
        ),
      ],
    );
  }
}
