import 'package:equatable/equatable.dart';
import 'package:starter/features/auth/auth.dart';

class AppState extends Equatable {
  const AppState({
    this.currentSession,
    this.isInitialized = false,
    this.isTutorialShown = false,
    this.isLoaderVisible = false,
  });

  final AuthSession? currentSession;
  final bool isInitialized;
  final bool isTutorialShown;
  final bool isLoaderVisible;

  bool get isLogin => currentSession != null;
  bool get isCodeVerified => currentSession?.isEmailVerified ?? false;
  bool get isAccountCompleted => currentSession?.isProfileCompleted ?? false;

  AppState copyWith({
    AuthSession? Function()? currentSession,
    bool? isInitialized,
    bool? isTutorialShown,
    bool? isLoaderVisible,
  }) {
    return AppState(
      currentSession: currentSession != null ? currentSession() : this.currentSession,
      isInitialized: isInitialized ?? this.isInitialized,
      isTutorialShown: isTutorialShown ?? this.isTutorialShown,
      isLoaderVisible: isLoaderVisible ?? this.isLoaderVisible,
    );
  }

  @override
  List<Object?> get props => [currentSession, isInitialized, isTutorialShown, isLoaderVisible];
}
