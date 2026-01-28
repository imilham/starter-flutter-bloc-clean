import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/features/auth/domain/domain.dart';
import 'package:starter/utils/utils.dart';

part 'sign_up_state.dart';

/// Cubit for managing sign up form state.
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required RegisterUseCase registerUseCase,
  })  : _registerUseCase = registerUseCase,
        super(const SignUpInitial());

  final RegisterUseCase _registerUseCase;

  /// Attempts to register with the provided credentials.
  Future<void> signUp({
    required String email,
    required String password,    
    String? devicePushToken,
  }) async {
    emit(const SignUpLoading());

  final deviceId = await getIt<AppSettings>().getDeviceId();
  final deviceType = getIt<AppSettings>().getDevicePlatform();

    final result = await _registerUseCase(
      RegisterParams(
        email: email,
        password: password,
        deviceId: deviceId,
        deviceType: deviceType,
        devicePushToken: devicePushToken,
      ),
    );

    result.fold(
      onSuccess: (session) => emit(SignUpSuccess(session)),
      onFailure: (failure) => emit(SignUpFailure(failure.message)),
    );
  }

  /// Resets the sign up state.
  void reset() => emit(const SignUpInitial());
}
