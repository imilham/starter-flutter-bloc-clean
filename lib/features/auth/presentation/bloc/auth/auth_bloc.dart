import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/core.dart';
import 'package:starter/features/auth/domain/domain.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Global BLoC for managing authentication state.
///
/// This BLoC tracks whether the user is authenticated or not.
/// It's a singleton that lives for the entire app lifecycle.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required GetStoredSessionUseCase getStoredSessionUseCase,
    required LogoutUseCase logoutUseCase,
    required RefreshSessionUseCase refreshSessionUseCase,
  })  : _getStoredSessionUseCase = getStoredSessionUseCase,
        _logoutUseCase = logoutUseCase,
        _refreshSessionUseCase = refreshSessionUseCase,
        super(const AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSessionEstablished>(_onSessionEstablished);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthRefreshRequested>(_onAuthRefreshRequested);
  }

  final GetStoredSessionUseCase _getStoredSessionUseCase;
  final LogoutUseCase _logoutUseCase;
  final RefreshSessionUseCase _refreshSessionUseCase;

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _getStoredSessionUseCase(const NoParams());

    result.fold(
      onSuccess: (session) {
        if (session != null) {
          emit(AuthAuthenticated(session));
        } else {
          emit(const AuthUnauthenticated());
        }
      },
      onFailure: (_) => emit(const AuthUnauthenticated()),
    );
  }

  void _onSessionEstablished(
    AuthSessionEstablished event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthAuthenticated(event.session));
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('🚨 AuthBloc: _onAuthLogoutRequested received. Message: ${event.message}');
    final currentState = state;
    // We don't care if the API logout fails (e.g. 401/405), we just want to clear local state.
    // So we invoke the use case but don't wait for the result to dictate our state.
    if (currentState is AuthAuthenticated) {
      try {
        await _logoutUseCase(LogoutParams(token: currentState.session.accessToken));
      } catch (_) {
        // Ignore API logout errors
      }
    }
    emit(AuthUnauthenticated(message: event.message));
  }

  Future<void> _onAuthRefreshRequested(
    AuthRefreshRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _refreshSessionUseCase(const NoParams());

    result.fold(
      onSuccess: (session) => emit(AuthAuthenticated(session)),
      onFailure: (_) => emit(const AuthUnauthenticated()),
    );
  }
}
