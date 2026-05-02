part of 'common_button.dart';

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.onPressed,
    this.label,
    this.child,
    this.isLoading = false,
    this.isEnabled = true,
    this.size = CommonButtonSize.large,
    this.minimumSize,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.padding,
    this.shape,
    this.elevation,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    super.key,
  });

  final VoidCallback? onPressed;
  final String? label;
  final Widget? child;
  final bool isLoading;
  final bool isEnabled;
  final CommonButtonSize size;
  final Size? minimumSize;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;
  final double? elevation;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autofocus;

  static const double _smallWidth = 220.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final effectiveForeground = foregroundColor ?? colorScheme.onPrimary;

    Widget button = ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      onLongPress: isEnabled ? onLongPress : null,
      focusNode: focusNode,
      autofocus: autofocus,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        textStyle: textStyle,
        padding: padding,
        shape: shape,
        elevation: elevation,
      ).copyWith(
        minimumSize: (minimumSize != null || size == CommonButtonSize.small) ? WidgetStatePropertyAll(minimumSize ?? const Size(_smallWidth, 48)) : null,
      ),
      child: _ButtonContent(
        isLoading: isLoading,
        spinnerColor: effectiveForeground,
        iconColor: effectiveForeground,
        label: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        child: child,
      ),
    );

    if (isLoading) {
      button = AbsorbPointer(child: button);
    }

    return button;
  }
}
