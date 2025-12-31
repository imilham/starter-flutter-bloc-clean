import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starter/utils/utils.dart';

/// A horizontal step indicator widget for multi-step flows.
///
/// Displays a series of connected circles representing steps in a process,
/// with visual differentiation between completed, current, and pending steps.
///
/// ## Features
/// - 🎯 Animated transitions between step states
/// - ✅ Checkmark icons for completed steps
/// - 🎨 Theme-aware colors using [ColorScheme]
/// - 📏 Configurable step count and alignment
///
/// ## Step States
/// | State | Appearance |
/// |-------|------------|
/// | **Completed** | Filled primary color with checkmark |
/// | **Current** | Surface color with primary border and dot |
/// | **Pending** | Surface color with muted border and dot |
///
/// ## Example Usage
/// ```dart
/// StepIndicator(
///   length: 4,
///   currentIndex: 1, // Second step is current (0-indexed)
/// )
/// ```
///
/// ## Architecture
/// This widget uses the **Stateless Pattern** as all state is derived
/// from the [currentIndex] prop. Parent widgets control progression.
///
/// ## References
/// - [Stepper](https://api.flutter.dev/flutter/material/Stepper-class.html) - Flutter's built-in stepper widget
/// - [Material Design Steppers](https://material.io/archive/guidelines/components/steppers.html)
///
/// See also:
/// - [Stepper] for a full-featured step-by-step form widget.
/// - [TabPageSelector] for dot-style page indicators.
class StepIndicator extends StatelessWidget {
  /// Creates a step indicator with the specified number of steps.
  ///
  /// The [length] must be at least 1, and [currentIndex] must be
  /// within the range `[0, length)`.
  const StepIndicator({
    required this.length,
    required this.currentIndex,
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.stepSize = 24.0,
    this.connectorLength = 24.0,
    this.connectorWidth = 2.0,
    this.animationDuration = const Duration(milliseconds: 300),
  })  : assert(length > 0, 'length must be at least 1'),
        assert(currentIndex >= 0 && currentIndex < length, 'currentIndex must be within [0, length)');

  /// Total number of steps to display.
  ///
  /// Must be at least 1.
  final int length;

  /// The index of the current step (0-indexed).
  ///
  /// Steps with index less than this are marked as completed.
  /// The step at this index is marked as current.
  /// Steps with index greater than this are marked as pending.
  final int currentIndex;

  /// Alignment of steps along the main (horizontal) axis.
  ///
  /// Defaults to [MainAxisAlignment.center].
  final MainAxisAlignment mainAxisAlignment;

  /// Alignment of steps along the cross (vertical) axis.
  ///
  /// Defaults to [CrossAxisAlignment.center].
  final CrossAxisAlignment crossAxisAlignment;

  /// Size (width and height) of each step circle.
  ///
  /// Defaults to 24.0 logical pixels.
  final double stepSize;

  /// Length of the connector line between steps.
  ///
  /// Defaults to 24.0 logical pixels.
  final double connectorLength;

  /// Width of the connector line between steps.
  ///
  /// Defaults to 2.0 logical pixels.
  final double connectorWidth;

  /// Duration of the step state transition animation.
  ///
  /// Defaults to 300 milliseconds.
  final Duration animationDuration;

  /// Returns the background color for a step based on its state.
  Color _getBackgroundColor(BuildContext context, int index) {
    final colorScheme = Theme.of(context).colorScheme;

    if (index < currentIndex) {
      // Completed step
      return colorScheme.primary;
    }
    // Current or pending step
    return colorScheme.surface;
  }

  /// Returns the border color for a step based on its state.
  Color _getBorderColor(BuildContext context, int index) {
    final colorScheme = Theme.of(context).colorScheme;

    if (index < currentIndex || index == currentIndex) {
      // Completed or current step
      return colorScheme.primary;
    }
    // Pending step
    return colorScheme.onSurface.withValues(alpha: 0.5);
  }

  /// Returns the content (icon/dot) color for a step based on its state.
  Color _getContentColor(BuildContext context, int index) {
    final colorScheme = Theme.of(context).colorScheme;

    if (index < currentIndex) {
      // Completed step - checkmark color
      return colorScheme.onPrimary;
    } else if (index == currentIndex) {
      // Current step - dot color
      return colorScheme.primary;
    }
    // Pending step - dot color
    return colorScheme.onSurface.withValues(alpha: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: List.generate(length, (index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Connector line (except for first step)
            if (index != 0)
              Container(
                width: connectorLength,
                height: connectorWidth,
                color: _getBorderColor(context, index),
              ),

            // Step circle
            _buildStepCircle(context, index),
          ],
        );
      }),
    );
  }

  /// Builds an individual step circle with animation.
  Widget _buildStepCircle(BuildContext context, int index) {
    final isCompleted = index < currentIndex;
    final contentColor = _getContentColor(context, index);

    return AnimatedContainer(
      duration: animationDuration,
      curve: Curves.easeInOut,
      width: stepSize,
      height: stepSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getBackgroundColor(context, index),
        border: Border.all(
          color: _getBorderColor(context, index),
          width: 1.5,
        ),
      ),
      child: Center(
        child: isCompleted
            ? Icon(
                FontAwesomeIcons.check,
                color: contentColor,
                size: stepSize * 0.6,
              )
            : Container(
                width: stepSize * 0.33,
                height: stepSize * 0.33,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: contentColor,
                ),
              ),
      ),
    );
  }
}
