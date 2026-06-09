import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Service for checking and monitoring network connectivity status.
///
/// Wraps the `connectivity_plus` package to provide a clean API
/// for the rest of the app.
///
/// ## Usage
/// ```dart
/// final connectivityService = GetIt.instance<ConnectivityService>();
///
/// // One-time check
/// if (await connectivityService.hasConnectivity()) { /* online */ }
///
/// // Listen to changes
/// connectivityService.onConnectivityChanged.listen((isConnected) {
///   if (!isConnected) showNoConnectionBanner();
/// });
/// ```
class ConnectivityService {
  ConnectivityService() {
    _connectivity.checkConnectivity().then((results) {
      _isConnectedCached = _isConnected(results);
      _controller.add(_isConnectedCached);
    });

    _subscription = _connectivity.onConnectivityChanged.listen(
      (results) {
        _isConnectedCached = _isConnected(results);
        log(
          'Connectivity changed: $_isConnectedCached (results: $results)',
          name: 'ConnectivityService',
        );
        _controller.add(_isConnectedCached);
      },
    );
  }

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  /// Holds the last known connectivity state for synchronous checks.
  bool _isConnectedCached = true;

  /// Returns the current cached connectivity status synchronously.
  ///
  /// Efficient for high-frequency checks (e.g. per-API call).
  bool get isConnected => _isConnectedCached;

  /// Stream that emits `true` when connected, `false` when disconnected.
  Stream<bool> get onConnectivityChanged => _controller.stream;

  /// Checks current connectivity status asynchronously.
  Future<bool> hasConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      return _isConnected(results);
    } catch (e) {
      log('Error checking connectivity: $e', name: 'ConnectivityService');
      return true;
    }
  }

  bool _isConnected(List<ConnectivityResult> results) {
    return results.any((r) => r != ConnectivityResult.none);
  }

  void dispose() {
    _subscription?.cancel();
    _controller.close();
  }
}
