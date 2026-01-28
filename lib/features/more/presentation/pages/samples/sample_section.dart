import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

class SampleSection extends StatelessWidget {
  const SampleSection({
    required this.title, required this.icon, required this.children, super.key,
    this.isExpanded = false,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        leading: Icon(icon, color: context.colorScheme.primary),
        title: Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        childrenPadding: const EdgeInsets.all(16),
        children: children,
      ),
    );
  }
}
