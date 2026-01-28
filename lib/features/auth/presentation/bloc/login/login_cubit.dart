import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/auth/domain/domain.dart';

part 'login_state.dart';

/// Cubit for managing login form state.
class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required LoginUseCase loginUseCase,
  })  : _loginUseCase = loginUseCase,
        super(const LoginInitial());

  final LoginUseCase _loginUseCase;

  /// Attempts to log in with the provided credentials.
  Future<void> login({
    required String email,
    required String password,
    required String deviceId,
    required String deviceType,
    String? devicePushToken,
  }) async {
    emit(const LoginLoading());

    final result = await _loginUseCase(
      LoginParams(
        email: email,
        password: password,
        deviceId: deviceId,
        deviceType: deviceType,
        devicePushToken: devicePushToken,
      ),
    );

    result.fold(
      onSuccess: (session) => emit(LoginSuccess(session)),
      onFailure: (failure) => emit(LoginFailure(failure.message)),
    );
  }

  /// Resets the login state.
  void reset() => emit(const LoginInitial());
}
