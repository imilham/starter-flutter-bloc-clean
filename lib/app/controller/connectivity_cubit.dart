import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/controller/connectivity_state.dart';
import 'package:starter/utils/network/connectivity_service.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit(this._connectivityService)
      : super(const ConnectivityState()) {
    _subscription = _connectivityService.onConnectivityChanged.listen(
      (isConnected) {
        emit(
          state.copyWith(
            isConnected: isConnected,
            isInitialized: true,
          ),
        );
      },
    );
  }

  final ConnectivityService _connectivityService;
  late final StreamSubscription<bool> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
