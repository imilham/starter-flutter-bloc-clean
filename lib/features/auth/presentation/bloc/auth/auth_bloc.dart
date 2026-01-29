import 'package:equatable/equatable.dart';
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
  })  : _getStoredSessionUseCase = getStoredSessionUseCase,
        _logoutUseCase = logoutUseCase,
        super(const AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSessionEstablished>(_onSessionEstablished);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  final GetStoredSessionUseCase _getStoredSessionUseCase;
  final LogoutUseCase _logoutUseCase;

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
    final currentState = state;
    if (currentState is AuthAuthenticated) {
      await _logoutUseCase(LogoutParams(token: currentState.session.accessToken));
    }
    emit(const AuthUnauthenticated());
  }
}
