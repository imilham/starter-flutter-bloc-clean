part of 'common_button.dart';

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.isLoading,
    required this.spinnerColor,
    this.label,
    this.child,
    this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
  });

  final bool isLoading;
  final Color spinnerColor;
  final String? label;
  final Widget? child;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? iconColor;

  static const double _iconSize = 18;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: _iconSize,
        width: _iconSize,
        child: CircularProgressIndicator(
          color: spinnerColor,
          strokeWidth: 2,
        ),
      );
    }

    if (child != null) return child!;

    if (prefixIcon == null && suffixIcon == null) {
      return Text(label ?? '');
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          Icon(prefixIcon, size: _iconSize, color: iconColor),
          const SizedBox(width: 8),
        ],
        Text(label ?? ''),
        if (suffixIcon != null) ...[
          const SizedBox(width: 8),
          Icon(suffixIcon, size: _iconSize, color: iconColor),
        ],
      ],
    );
  }
}
