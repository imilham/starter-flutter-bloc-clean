import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter/utils/utils.dart';

/// A customizable App Bar that provides a consistent look and feel across the application.
///
/// Features:
/// - Supports both String and Widget for [title].
/// - Toggles back button visibility via [showBackButton].
/// - Custom [actions] and [bottom] widget (for Tabs).
/// - Platform-adaptive [centerTitle].
/// - Custom [backgroundColor] and [onBackPress] callback.
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a common app bar.
  const CommonAppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.leading,
    this.actions,
    this.centerTitle,
    this.bottom,
    this.backgroundColor,
    this.onBackPress,
    this.systemOverlayStyle,
  });

  /// The title of the app bar. Can be a [String] or a [Widget].
  ///
  /// If a [String] is provided, it is wrapped in a [Text] widget with the
  /// corresponding theme style.
  final dynamic title;

  /// Whether to show the leading back button.
  ///
  /// Defaults to true. If false, the leading widget is null (unless implied by the navigation stack).
  final bool showBackButton;

  /// A list of Widgets to display in a row after the [title].
  final List<Widget>? actions;

  /// Whether the title should be centered.
  ///
  /// If null, defaults to platform-specific behavior (centered on iOS, left on Android).
  final bool? centerTitle;

  /// This widget appears across the bottom of the app bar.
  ///
  /// Typically a [TabBar]. Only widgets that implement [PreferredSizeWidget] can be used.
  final PreferredSizeWidget? bottom;

  /// The background color to use for the app bar.
  final Color? backgroundColor;

  /// Callback when the back button is pressed.
  ///
  /// If provided, this replaces the default `Navigator.pop(context)` behavior.
  final VoidCallback? onBackPress;

  /// A widget to display before the [title].
  ///
  /// If provided, this overrides the default back button.
  final Widget? leading;

  /// Defines the status bar color and icon brightness.
  ///
  /// Use [SystemUiOverlayStyle.dark] or [SystemUiOverlayStyle.light].
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Resolve title widget
    Widget? titleWidget;
    if (title is String) {
      titleWidget = Text(
        title as String,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      );
    } else if (title is Widget) {
      titleWidget = title as Widget;
    }

    return AppBar(
      title: titleWidget,
      centerTitle: centerTitle,
      automaticallyImplyLeading: showBackButton,
      leading: leading ??
          (showBackButton && context.canPop()
              ? IconButton(
                  icon: Platform.isAndroid ? const Icon(Icons.arrow_back) : const Icon(Icons.arrow_back_ios),
                  onPressed: onBackPress ?? () => context.pop(),
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                )
              : null),
      actions: actions,
      bottom: bottom,
      backgroundColor: backgroundColor,
      systemOverlayStyle: systemOverlayStyle,
      elevation: 0,
      scrolledUnderElevation: 2,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );
}
