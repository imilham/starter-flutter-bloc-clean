import 'package:flutter/material.dart';

class CommonEmptyWidget extends StatelessWidget {
  const CommonEmptyWidget({
    super.key,
    this.icon,
    this.iconData = Icons.hourglass_empty,
    this.title = 'No items found',
    this.subtitle,
    this.actionLabel,
    this.onActionPressed,
    this.iconSize = 64,
    this.iconColor = Colors.grey,
  });

  final Widget? icon;
  final IconData iconData;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final double iconSize;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? Icon(iconData, size: iconSize, color: iconColor),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onActionPressed != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onActionPressed,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
