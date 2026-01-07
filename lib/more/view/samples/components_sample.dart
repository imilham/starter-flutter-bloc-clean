import 'package:flutter/material.dart';
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
        Gap.medium16,
        PasswordFormField(
          controller: _passController,
          title: 'Password Input',
          hintText: 'Password',
        ),
        Gap.medium16,
        Gap.medium16,
        CommonBaseTextField(
          controller: TextEditingController(),
          title: 'Read Only Input',
          hintText: 'Cannot edit this',
          readOnly: true,
        ),
        Gap.medium12,
        const SectionHeader(title: 'Date Conversion'),
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
        Gap.extraLarge32,
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
    );
  }
}
