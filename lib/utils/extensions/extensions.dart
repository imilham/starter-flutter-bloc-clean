// ignore_for_file: comment_references

/// Extensions for common Flutter patterns.
///
/// Available extensions:
/// - [ThemeExtension] - Easy access to theme, text styles, and colors
///
/// ## Usage
/// ```dart
/// import 'package:starter/utils/extensions/extensions.dart';
///
/// // Text styles
/// Text('Hello', style: context.bodyMedium)
/// Text('Title', style: context.titleLarge)
///
/// // Colors
/// color: context.colorScheme.primary
/// color: context.colorScheme.error
///
/// // Theme
/// final theme = context.theme;
/// ```
library;

export 'theme_extension.dart';
