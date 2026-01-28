import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

// TODO: remove-samples-im

/// Sample page showcasing all available extensions in the app.
class ExtensionsSample extends StatelessWidget {
  const ExtensionsSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ─────────────────────────────────────────────────────────────────
        // NUMBER & CURRENCY EXTENSIONS
        // ─────────────────────────────────────────────────────────────────
        const SectionHeader.large('Number & Currency Extensions'),
        const Text('Formatting and layout shortcuts for numbers'),
        Gap.medium16,

        const _ExtensionCard(
          title: 'Formatting',
          children: [
            _ExtensionItem(
              code: '1000.toCurrency()',
              description: 'Currency format',
              demo: Text(r'$1,000.00'), // Simulated result logic is generic
            ),
            _ExtensionItem(
              code: '1500000.compact()',
              description: 'Compact format',
              demo: Text('1.5M'),
            ),
            _ExtensionItem(
              code: '0.123.toPercent()',
              description: 'Percent format',
              demo: Text('12%'),
            ),
          ],
        ),

        Gap.medium16,
        const Divider(height: 32),

        // ─────────────────────────────────────────────────────────────────
        // COLOR EXTENSIONS
        // ─────────────────────────────────────────────────────────────────
        const SectionHeader.large('Color Extensions'),
        const Text('Manipulation and utility for Colors'),
        Gap.medium16,

        _ExtensionCard(
          title: 'Manipulation',
          children: [
            _ExtensionItem(
              code: 'color.darken(0.2)\ncolor.lighten(0.2)',
              description: 'Adjust lightness',
              demo: Row(
                children: [
                  _ColorBox(context.colorScheme.primary.darken(0.2), 'Darker'),
                  _ColorBox(context.colorScheme.primary, 'Normal'),
                  _ColorBox(context.colorScheme.primary.lighten(0.2), 'Lighter'),
                ],
              ),
            ),
            _ExtensionItem(
              code: 'color.complementary',
              description: 'Complementary color',
              demo: Row(
                children: [
                  const _ColorBox(Colors.blue, 'Blue'),
                  _ColorBox(Colors.blue.complementary, 'Comp'),
                ],
              ),
            ),
            const _ExtensionItem(
              code: 'color.toHex()',
              description: 'Hex string (e.g. #FF0000)',
            ),
          ],
        ),

        const Divider(height: 32),

        // ─────────────────────────────────────────────────────────────────
        // DECORATION EXTENSIONS
        // ─────────────────────────────────────────────────────────────────
        const SectionHeader.large('Decoration Extensions'),
        const Text('Quick styling shortcuts'),
        Gap.medium16,

        _ExtensionCard(
          title: 'Containers & Effects',
          children: [
            _ExtensionItem(
              code: 'widget.card()',
              description: 'Wrap in Card',
              demo: const Text('I am in a card').paddingAll16.card(),
            ),
            _ExtensionItem(
              code: 'widget.glassmorphism()',
              description: 'Glass effect',
              demo: Container(
                height: 60,
                width: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
                ),
                child: Center(
                  child: const Text('Glass')
                      .paddingAll16
                      .glassmorphism(opacity: 0.1, blur: 5)
                      .paddingAll8,
                ),
              ),
            ),
            _ExtensionItem(
              code: 'widget.withBorder()',
              description: 'Add border',
              demo: const Text('Bordered').paddingAll8.withBorder(color: Colors.red),
            ),
            _ExtensionItem(
              code: 'widget.withShadow()',
              description: 'Add shadow',
              demo: const Text('Shadowed').paddingAll8.withBackground(Colors.white).withShadow(),
            ),
          ],
        ),

        const Divider(height: 32),

        // ─────────────────────────────────────────────────────────────────
        // WIDGET LAYOUT EXTENSIONS
        // ─────────────────────────────────────────────────────────────────
        const SectionHeader.large('Widget Layout Extensions'),
        const Text('Extensions on Widget for layout, visibility, interaction'),
        Gap.medium16,

        _ExtensionCard(
          title: 'Layout Shortcuts',
          children: [
            _ExtensionItem(
              code: 'widget.expanded',
              description: 'Wrap in Expanded',
              demo: Row(
                children: [
                  Container(
                    height: 30,
                    color: context.colorScheme.primary.withValues(alpha: 0.3),
                    child: const Text('I expand!').center,
                  ).expanded,
                ],
              ),
            ),
            const _ExtensionItem(
              code: 'widget.center',
              description: 'Wrap in Center',
            ),
            const _ExtensionItem(
              code: 'widget.safeArea',
              description: 'Wrap in SafeArea',
            ),
            const _ExtensionItem(
              code: 'widget.sizedBox(width: 100, height: 50)',
              description: 'Constrain size',
            ),
            const _ExtensionItem(
              code: 'widget.aspectRatio(ratio: 16/9)',
              description: 'Maintain aspect ratio',
            ),
          ],
        ),

        Gap.medium16,
        _ExtensionCard(
          title: 'Visibility & Opacity',
          children: [
            _ExtensionItem(
              code: 'widget.visible(isVisible: true)',
              description: 'Show/hide widget',
              demo: Row(
                children: [
                  const Text('Visible: '),
                  const Icon(Icons.check, color: Colors.green).visible(isVisible: true),
                  Gap.small8,
                  const Text('Hidden: '),
                  const Icon(Icons.close, color: Colors.red).visible(isVisible: false),
                ],
              ),
            ),
            _ExtensionItem(
              code: 'widget.opacity(value: 0.5)',
              description: 'Apply opacity',
              demo: Row(
                children: [
                  Container(width: 40, height: 40, color: context.colorScheme.primary),
                  Gap.small8,
                  Container(width: 40, height: 40, color: context.colorScheme.primary).opacity(value: 0.5),
                  Gap.small8,
                  Container(width: 40, height: 40, color: context.colorScheme.primary).opacity(value: 0.2),
                ],
              ),
            ),
          ],
        ),

        Gap.medium16,
        _ExtensionCard(
          title: 'Transforms',
          children: [
            _ExtensionItem(
              code: 'widget.scale(factor: 1.5)',
              description: 'Scale transform',
              demo: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.star, size: 24),
                  const Icon(Icons.star, size: 24).scale(factor: 1.5),
                  const Icon(Icons.star, size: 24).scale(factor: 2),
                ],
              ),
            ),
            _ExtensionItem(
              code: 'widget.rotate(angle: pi/4)',
              description: 'Rotate (radians)',
              demo: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.arrow_upward),
                  const Icon(Icons.arrow_upward).rotate(angle: pi / 4),
                  const Icon(Icons.arrow_upward).rotate(angle: pi / 2),
                ],
              ),
            ),
            const _ExtensionItem(
              code: 'widget.rotateDegrees(degrees: 45)',
              description: 'Rotate (degrees)',
            ),
          ],
        ),

        Gap.medium16,
        const _ExtensionCard(
          title: 'Pointer Handling',
          children: [
            _ExtensionItem(
              code: 'widget.ignore(isIgnoring: true)',
              description: 'IgnorePointer wrapper',
            ),
            _ExtensionItem(
              code: 'widget.absorb(isAbsorbing: true)',
              description: 'AbsorbPointer wrapper',
            ),
          ],
        ),

        Gap.medium16,
        const _ExtensionCard(
          title: 'Interaction',
          children: [
            _ExtensionItem(
              code: 'widget.onTap(() => ...)',
              description: 'InkWell/GestureDetector',
            ),
            _ExtensionItem(
              code: 'widget.onLongPress(() => ...)',
              description: 'Long press callback',
            ),
          ],
        ),

        Gap.medium16,
        _ExtensionCard(
          title: 'Accessibility & UX',
          children: [
            _ExtensionItem(
              code: "widget.tooltip(message: 'Info')",
              description: 'Add tooltip',
              demo: const Icon(Icons.info_outline).tooltip(message: 'This shows a tooltip'),
            ),
            const _ExtensionItem(
              code: "widget.hero(tag: 'profile')",
              description: 'Hero animation',
            ),
            const _ExtensionItem(
              code: "widget.semantics(label: 'Button')",
              description: 'Accessibility label',
            ),
          ],
        ),

        const Divider(height: 32),

        // ─────────────────────────────────────────────────────────────────
        // WIDGET PADDING EXTENSIONS
        // ─────────────────────────────────────────────────────────────────
        const SectionHeader.large('Padding Extensions'),
        const Text('Extensions on Widget for quick padding'),
        Gap.medium16,

        const _ExtensionCard(
          title: 'All Sides',
          children: [
            _ExtensionItem(code: 'widget.paddingAll4', description: '4px all'),
            _ExtensionItem(code: 'widget.paddingAll8', description: '8px all'),
            _ExtensionItem(code: 'widget.paddingAll16', description: '16px all'),
            _ExtensionItem(code: 'widget.paddingAll24', description: '24px all'),
          ],
        ),

        Gap.medium16,
        const _ExtensionCard(
          title: 'Horizontal / Vertical',
          children: [
            _ExtensionItem(code: 'widget.paddingHorizontal16', description: '16px horizontal'),
            _ExtensionItem(code: 'widget.paddingVertical8', description: '8px vertical'),
            _ExtensionItem(
              code: 'widget.paddingOnly(l: 8, t: 16)',
              description: 'Custom sides',
            ),
          ],
        ),

        const Divider(height: 32),

        // ─────────────────────────────────────────────────────────────────
        // BORDER RADIUS EXTENSIONS
        // ─────────────────────────────────────────────────────────────────
        const SectionHeader.large('Border Radius Extensions'),
        const Text('Extensions on Widget for clipping'),
        Gap.medium16,

        _ExtensionCard(
          title: 'All Corners',
          children: [
            _ExtensionItem(
              code: 'widget.clipRadius8',
              description: '8px all corners',
              demo: Container(
                width: 60,
                height: 60,
                color: context.colorScheme.secondary,
              ).clipRadius8,
            ),
            const _ExtensionItem(code: 'widget.clipRadius16', description: '16px all corners'),
            const _ExtensionItem(code: 'widget.clipRadius(999)', description: 'Pill shape'),
            const _ExtensionItem(code: 'widget.clipOval', description: 'Circle/oval'),
          ],
        ),

        const Divider(height: 32),

        // ─────────────────────────────────────────────────────────────────
        // LIST EXTENSIONS
        // ─────────────────────────────────────────────────────────────────
        const SectionHeader.large('List<Widget> Extensions'),
        const Text('Extensions on List<Widget>'),
        Gap.medium16,

        _ExtensionCard(
          title: 'List Conversions',
          children: [
            _ExtensionItem(
              code: '[w1, w2].toColumn()',
              description: 'Convert to Column',
              demo: [
                const Text('A'),
                const Text('B'),
                const Text('C'),
              ].toColumn(mainAxisSize: MainAxisSize.min),
            ),
            _ExtensionItem(
              code: '[w1, w2].toRow()',
              description: 'Convert to Row',
              demo: [
                const Icon(Icons.star),
                const Icon(Icons.star),
                const Icon(Icons.star),
              ].toRow(mainAxisSize: MainAxisSize.min),
            ),
            // _ExtensionItem(
            //   code: '[w1, w2].toStack()',
            //   description: 'Convert to Stack',
            //   demo: [
            //     const Icon(
            //       Icons.star,
            //       color: Colors.yellow,
            //       size: 64,
            //     ),
            //     const Icon(
            //       Icons.star,
            //       color: Colors.red,
            //       size: 48,
            //     ).positioned(right: 0, bottom: 0),
            //     const Icon(
            //       Icons.star,
            //       color: Colors.green,
            //       size: 32,
            //     ).positioned(left: 0, top: 0),
            //   ].toStack(
            //     alignment: Alignment.center,
            //     fit: StackFit.expand,
            //   ),
            // ),
            const _ExtensionItem(
              code: '[w1, w2].toWrap(spacing: 8)',
              description: 'Convert to Wrap',
            ),
            const _ExtensionItem(
              code: '[w1, w2].separatedBy(Gap.small8)',
              description: 'Insert separators',
            ),
          ],
        ),

        const Divider(height: 32),

        // ─────────────────────────────────────────────────────────────────
        // CONTEXT EXTENSIONS
        // ─────────────────────────────────────────────────────────────────
        const SectionHeader.large('BuildContext Extensions'),
        const Text('Easy access to theme, colors, screen size'),
        Gap.medium16,

        const _ExtensionCard(
          title: 'Theme Access',
          children: [
            _ExtensionItem(code: 'context.theme', description: 'ThemeData'),
            _ExtensionItem(code: 'context.colorScheme', description: 'ColorScheme'),
            _ExtensionItem(code: 'context.textTheme', description: 'TextTheme'),
            _ExtensionItem(code: 'context.appColors', description: 'Custom AppColors'),
          ],
        ),

        Gap.medium16,
        const _ExtensionCard(
          title: 'Text Styles',
          children: [
            _ExtensionItem(code: 'context.bodyMedium', description: 'Body medium style'),
            _ExtensionItem(code: 'context.headlineLarge', description: 'Headline large'),
            _ExtensionItem(code: 'context.labelSmall', description: 'Label small'),
          ],
        ),

        Gap.medium16,
        _ExtensionCard(
          title: 'Screen Size',
          children: [
            const _ExtensionItem(code: 'context.screenWidth', description: 'Screen width'),
            const _ExtensionItem(code: 'context.screenHeight', description: 'Screen height'),
            const _ExtensionItem(code: 'context.isLandscape', description: 'Orientation check'),
            _ExtensionItem(
              code: 'context.isDarkMode',
              description: 'Theme Mode',
              demo: Builder(builder: (c) => Text('${c.isDarkMode}')),
            ),
            _ExtensionItem(
              code: 'context.isTablet',
              description: 'Tablet check (>600px)',
              demo: Builder(builder: (c) => Text('${c.isTablet}')),
            ),
          ],
        ),

        const Divider(height: 32),

        // ─────────────────────────────────────────────────────────────────
        // SNACKBAR EXTENSIONS
        // ─────────────────────────────────────────────────────────────────
        const SectionHeader.large('SnackBar Extensions'),
        const Text('Quick snackbar display'),
        Gap.medium16,

        const _ExtensionCard(
          title: 'SnackBar Methods',
          children: [
            _ExtensionItem(
              code: "context.showSnackBar('Message')",
              description: 'Default snackbar',
            ),
            _ExtensionItem(
              code: "context.showSuccessSnackBar('Done!')",
              description: 'Green success',
            ),
            _ExtensionItem(
              code: "context.showErrorSnackBar('Error!')",
              description: 'Red error',
            ),
          ],
        ),

        const Divider(height: 32),

        // ─────────────────────────────────────────────────────────────────
        // CORE EXTENSIONS
        // ─────────────────────────────────────────────────────────────────
        const SectionHeader.large('Core Extensions'),
        const Text('String, List, DateTime utilities'),
        Gap.medium16,

        _ExtensionCard(
          title: 'String Extensions',
          children: [
            const _ExtensionItem(code: 'nullableString.orEmpty', description: "Null-safe ''"),
            const _ExtensionItem(code: 'str.capitalize', description: 'Capitalize first'),
            const _ExtensionItem(code: 'str.isValidEmail', description: 'Email validation'),
            _ExtensionItem(
              code: 'str.isValidPassword',
              description: 'Password check (min 8, 1 letter, 1 number)',
              demo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('pass1 (invalid): ${"pass1".isValidPassword}'),
                  Text('Password123 (valid): ${"Password123".isValidPassword}'),
                ],
              ),
            ),
            const _ExtensionItem(
              code: '"hello world".toTitleCase',
              description: 'Title Case',
              demo: Text('Hello World'),
            ),
            const _ExtensionItem(
              code: '"  foo  ".removeWhitespace',
              description: 'Remove whitespace',
              demo: Text('foo'),
            ),
          ],
        ),

        Gap.medium16,
        const _ExtensionCard(
          title: 'DateTime Extensions',
          children: [
            _ExtensionItem(code: "date.format('dd MMM yyyy')", description: 'Format date'),
            _ExtensionItem(code: 'date.isToday', description: 'Check if today'),
            _ExtensionItem(code: 'date.formatWithSuffix', description: '1st January'),
          ],
        ),

        Gap.medium16,
        const _ExtensionCard(
          title: 'Duration Extensions',
          children: [
            _ExtensionItem(code: '500.milliseconds', description: 'Duration'),
            _ExtensionItem(code: '2.seconds', description: 'Duration'),
            _ExtensionItem(code: '5.minutes', description: 'Duration'),
          ],
        ),

        const Divider(height: 32),

        // ─────────────────────────────────────────────────────────────────
        // TEXT STYLE EXTENSIONS
        // ─────────────────────────────────────────────────────────────────
        const SectionHeader.large('TextStyle Extensions'),
        const Text('Fluent API for text styling'),
        Gap.medium16,

        _ExtensionCard(
          title: 'Fluent Modifiers',
          children: [
            _ExtensionItem(
              code: 'style.bold',
              description: 'FontWeight.bold',
              demo: Text('Bold', style: context.bodyMedium?.copyWith().bold),
            ),
            _ExtensionItem(
              code: 'style.italic',
              description: 'FontStyle.italic',
              demo: Text('Italic', style: context.bodyMedium?.copyWith().italic),
            ),
            _ExtensionItem(
              code: 'style.underline',
              description: 'TextDecoration.underline',
              demo: Text('Underline', style: context.bodyMedium?.copyWith().underline),
            ),
            const _ExtensionItem(
              code: 'style.setColor(Colors.red)',
              description: 'Set color',
            ),
          ],
        ),

        const Divider(height: 32),

        // ─────────────────────────────────────────────────────────────────
        // SEMANTIC TEXT STYLES (styles.dart)
        // ─────────────────────────────────────────────────────────────────
        const SectionHeader.large('Semantic Text Styles (styles.dart)'),
        const Text('Pre-defined text style helper functions from styles.dart'),
        Gap.medium16,

        _ExtensionCard(
          title: 'Headlines',
          children: [
            _ExtensionItem(
              code: 'headline32()',
              description: '32sp Bold',
              demo: Text('Headline 32', style: headline32()),
            ),
            _ExtensionItem(
              code: 'headline24()',
              description: '24sp Bold',
              demo: Text('Headline 24', style: headline24()),
            ),
            _ExtensionItem(
              code: 'headline20()',
              description: '20sp Bold',
              demo: Text('Headline 20', style: headline20()),
            ),
            _ExtensionItem(
              code: 'headline16()',
              description: '16sp Bold',
              demo: Text('Headline 16', style: headline16()),
            ),
            _ExtensionItem(
              code: 'headline14()',
              description: '14sp Bold',
              demo: Text('Headline 14', style: headline14()),
            ),
          ],
        ),

        Gap.medium16,
        _ExtensionCard(
          title: 'Body',
          children: [
            _ExtensionItem(
              code: 'bodyRegular16()',
              description: '16sp Regular',
              demo: Text('Body Regular 16', style: bodyRegular16()),
            ),
            _ExtensionItem(
              code: 'bodySmall14()',
              description: '14sp Medium',
              demo: Text('Body Small 14', style: bodySmall14()),
            ),
            _ExtensionItem(
              code: 'bodyXSmall12()',
              description: '12sp Regular',
              demo: Text('Body XSmall 12', style: bodyXSmall12()),
            ),
          ],
        ),

        Gap.medium16,
        _ExtensionCard(
          title: 'Buttons',
          children: [
            _ExtensionItem(
              code: 'buttonRegular16()',
              description: '16sp Bold',
              demo: Text('Button Regular', style: buttonRegular16()),
            ),
            _ExtensionItem(
              code: 'buttonSmall14()',
              description: '14sp Bold',
              demo: Text('Button Small', style: buttonSmall14()),
            ),
            _ExtensionItem(
              code: 'buttonXSmall12()',
              description: '12sp Bold',
              demo: Text('Button XSmall', style: buttonXSmall12()),
            ),
          ],
        ),

        Gap.medium16,
        _ExtensionCard(
          title: 'Form & Tabs',
          children: [
            _ExtensionItem(
              code: 'formLabel14()',
              description: '14sp Medium',
              demo: Text('Form Label', style: formLabel14()),
            ),
            _ExtensionItem(
              code: 'formHint16()',
              description: '16sp Medium',
              demo: Text('Form Hint', style: formHint16()),
            ),
            _ExtensionItem(
              code: 'tab10()',
              description: '10sp Medium',
              demo: Text('Tab Text', style: tab10()),
            ),
          ],
        ),

        Gap.medium16,
        _ExtensionCard(
          title: 'With Parameters',
          children: [
            _ExtensionItem(
              code: 'bodyRegular16(fontWeight: FontWeight.bold)',
              description: 'Override weight',
              demo: Text('Bold Body', style: bodyRegular16(fontWeight: FontWeight.bold)),
            ),
            _ExtensionItem(
              code: 'bodyRegular16(textColor: Colors.red)',
              description: 'Override color',
              demo: Text('Colored Body', style: bodyRegular16(textColor: Colors.red)),
            ),
            _ExtensionItem(
              code: 'bodyRegular16(fontStyle: FontStyle.italic)',
              description: 'Italic style',
              demo: Text('Italic Body', style: bodyRegular16(fontStyle: FontStyle.italic)),
            ),
          ],
        ),

        Gap.extraLarge32,
      ],
    );
  }
}

class _ExtensionCard extends StatelessWidget {
  const _ExtensionCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            Gap.small8,
            ...children,
          ],
        ),
      ),
    );
  }
}

class _ExtensionItem extends StatelessWidget {
  const _ExtensionItem({
    required this.code,
    required this.description,
    this.demo,
  });

  final String code;
  final String description;
  final Widget? demo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerHighest,
                    borderRadius: AppRadius.small8,
                  ),
                  child: Text(
                    code,
                    style: context.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              Gap.small8,
              Expanded(
                flex: 2,
                child: Text(
                  description,
                  style: context.bodySmall?.copyWith(color: Colors.grey),
                ),
              ),
            ],
          ),
          if (demo != null) ...[
            Gap.small8,
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                borderRadius: AppRadius.small8,
              ),
              child: demo,
            ),
          ],
        ],
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {
  const _ColorBox(this.color, this.label);
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: 40, height: 40, color: color),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10)),
        const SizedBox(width: 8),
      ],
    );
  }
}
