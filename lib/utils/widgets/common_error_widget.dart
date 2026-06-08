import 'package:flutter/material.dart';

class CommonErrorWidget extends StatelessWidget {
  const CommonErrorWidget({
    super.key,
    this.icon,
    this.iconData = Icons.error_outline,
    this.title = 'Oops!',
    this.errorMessage = 'Something went wrong. Please try again.',
    this.retryLabel = 'Retry',
    this.onRetry,
    this.iconSize = 64,
    this.iconColor = Colors.red,
  });

  final Widget? icon;
  final IconData iconData;
  final String title;
  final String errorMessage;
  final String retryLabel;
  final VoidCallback? onRetry;
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
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(retryLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
