import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:starter/app/controller/app_state.dart';
import 'package:starter/features/auth/auth.dart';

/// The prefix for shell routes. Use this constant wherever the home path prefix is needed.
const String homeRoutePrefix = '/shell';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  /// Restores persisted settings from Hive on app start.
  Future<void> onAppStart() async {
    final isTutorialShown = Hive.box<bool>('states').get('isTutorialShown') ?? false;
    emit(state.copyWith(isTutorialShown: isTutorialShown));
  }

  void setSession(AuthSession? session) {
    emit(state.copyWith(currentSession: () => session));
  }

  void setInitialized({required bool value}) {
    emit(state.copyWith(isInitialized: value));
  }

  void setTutorialShown({required bool value}) {
    Hive.box<bool>('states').put('isTutorialShown', value);
    emit(state.copyWith(isTutorialShown: value));
  }

  void showLoader() {
    if (!state.isLoaderVisible) {
      emit(state.copyWith(isLoaderVisible: true));
    }
  }

  void hideLoader() {
    if (state.isLoaderVisible) {
      emit(state.copyWith(isLoaderVisible: false));
    }
  }
}
