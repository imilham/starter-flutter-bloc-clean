import 'package:flutter/material.dart';

/// A reusable StreamBuilder wrapper with built-in loading and error handling.
///
/// This widget simplifies the common pattern of showing different UI states
/// based on stream data (loading, error, success).
///
/// ## Example Usage
/// ```dart
/// CommonStreamBuilder<AuthState>(
///   stream: authService.onAuthStateChanges,
///   loading: const CircularProgressIndicator(),
///   builder: (state) => MyWidget(state: state),
/// )
/// ```
///
/// ## With Custom Loading Check
/// ```dart
/// CommonStreamBuilder<AuthState>(
///   stream: authService.onAuthStateChanges,
///   isLoading: (state) => state is AuthLoading,
///   isError: (state) => state is AuthError,
///   loading: const CircularProgressIndicator(),
///   error: (state) => Text('Error occurred'),
///   builder: (state) => MyWidget(state: state),
/// )
/// ```
class CommonStreamBuilder<T> extends StatelessWidget {
  /// Creates a stream builder with built-in state handling.
  const CommonStreamBuilder({
    required this.stream,
    required this.builder,
    super.key,
    this.initialData,
    this.loading,
    this.error,
    this.isLoading,
    this.isError,
    this.getError,
  });

  /// The stream to listen to.
  final Stream<T> stream;

  /// Initial data for the stream.
  final T? initialData;

  /// Builder for the success state.
  final Widget Function(T state) builder;

  /// Widget to show while loading.
  ///
  /// If null, shows a centered CircularProgressIndicator.
  final Widget? loading;

  /// Builder for error state.
  ///
  /// If null, errors are passed to [builder].
  final Widget Function(T state)? error;

  /// Custom function to check if state represents loading.
  ///
  /// By default, checks if state has a runtime type containing 'Loading'.
  final bool Function(T state)? isLoading;

  /// Custom function to check if state represents an error.
  ///
  /// By default, checks if state has a runtime type containing 'Error'.
  final bool Function(T state)? isError;

  /// Function to extract error message from state.
  final String Function(T state)? getError;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      initialData: initialData,
      builder: (context, snapshot) {
        // Handle connection states
        if (snapshot.connectionState == ConnectionState.waiting && snapshot.data == null) {
          return loading ?? _defaultLoading();
        }

        // Handle stream errors
        if (snapshot.hasError) {
          return Center(
            child: Text('Stream error: ${snapshot.error}'),
          );
        }

        final data = snapshot.data;
        if (data == null) {
          return loading ?? _defaultLoading();
        }

        // Check for loading state
        if (_checkIsLoading(data)) {
          return loading ?? _defaultLoading();
        }

        // Check for error state
        if (_checkIsError(data)) {
          return error?.call(data) ?? builder(data);
        }

        // Success state
        return builder(data);
      },
    );
  }

  /// Default loading indicator.
  Widget _defaultLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  /// Check if state represents loading.
  bool _checkIsLoading(T state) {
    if (isLoading != null) {
      return isLoading!(state);
    }
    // Default: check if type name contains 'Loading'
    return state.runtimeType.toString().contains('Loading');
  }

  /// Check if state represents error.
  bool _checkIsError(T state) {
    if (isError != null) {
      return isError!(state);
    }
    // Default: check if type name contains 'Error'
    return state.runtimeType.toString().contains('Error');
  }
}
