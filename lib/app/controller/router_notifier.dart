import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:starter/app/controller/app_cubit.dart';
import 'package:starter/app/controller/app_state.dart';

/// Bridges [AppCubit] to [GoRouter.refreshListenable].
///
/// [GoRouter] requires a [Listenable]. Rather than polluting [AppCubit]
/// with [ChangeNotifier] concerns, this thin adapter subscribes to the
/// cubit's stream and calls [notifyListeners] on every emission.
class RouterNotifier extends ChangeNotifier {
  RouterNotifier(AppCubit appCubit) {
    _subscription = appCubit.stream.listen(_onStateChanged);
  }

  late final StreamSubscription<AppState> _subscription;

  void _onStateChanged(AppState _) => notifyListeners();

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
