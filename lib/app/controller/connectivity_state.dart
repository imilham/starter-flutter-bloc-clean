import 'package:equatable/equatable.dart';

class ConnectivityState extends Equatable {
  const ConnectivityState({
    this.isConnected = true,
    this.isInitialized = false,
  });

  /// Whether the device currently has a network connection.
  final bool isConnected;

  /// Becomes `true` after the first connectivity event is received.
  /// Prevents the offline banner from flashing on cold start.
  final bool isInitialized;

  ConnectivityState copyWith({
    bool? isConnected,
    bool? isInitialized,
  }) {
    return ConnectivityState(
      isConnected: isConnected ?? this.isConnected,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  List<Object?> get props => [isConnected, isInitialized];
}
