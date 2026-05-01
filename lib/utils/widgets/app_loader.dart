import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/app.dart';
import 'package:starter/utils/utils.dart';

/// A global loading overlay widget that wraps the entire app.
///
/// This widget listens to [AppCubit] and displays a semi-transparent overlay
/// with a loading indicator when [AppState.isLoaderVisible] is true.
///
/// ## Features
/// - 🚫 No BackdropFilter (performance optimized)
/// - ✨ Smooth fade animation (400ms)
/// - 🔒 Blocks user interaction when visible
/// - ⚡ Zero performance cost when not showing
///
/// ## Usage
/// ```dart
/// // Show loader before async operation
/// context.read<AppCubit>().showLoader();
///
/// try {
///   await someAsyncOperation();
/// } finally {
///   context.read<AppCubit>().hideLoader();
/// }
/// ```
///
/// This widget should be placed in [MaterialApp.builder] to cover
/// the entire app including dialogs and overlays.
class AppLoader extends StatefulWidget {
  /// Creates an AppLoader widget.
  const AppLoader({super.key, this.child});

  /// The child widget to display behind the loader overlay.
  final Widget? child;

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isOverlayVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void _onLoaderStateChanged(bool shouldShow) {
    if (!mounted) return;

    if (shouldShow && !_isOverlayVisible) {
      setState(() => _isOverlayVisible = true);
      _animationController.forward();
    } else if (!shouldShow && _isOverlayVisible) {
      _animationController.reverse().then((_) {
        if (mounted) {
          setState(() => _isOverlayVisible = false);
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listenWhen: (prev, curr) => prev.isLoaderVisible != curr.isLoaderVisible,
      listener: (context, state) => _onLoaderStateChanged(state.isLoaderVisible),
      child: Stack(
      children: [
        // Main app content
        Positioned.fill(child: widget.child ?? const SizedBox()),

        // Loading overlay
        if (_isOverlayVisible)
          Positioned.fill(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ColoredBox(
                color: Colors.black54,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const CommonCircularLoader(),
                  ),
                ),
              ),
            ),
          ),
      ],
      ),
    );
  }
}
