import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/auth/auth.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit({
    required VerifyEmailUseCase verifyEmailUseCase,
  })  : _verifyEmailUseCase = verifyEmailUseCase,
        super(const VerificationInitial());

  final VerifyEmailUseCase _verifyEmailUseCase;

  Future<void> verifyEmail({
    required String code,
    required String token, // In real app this comes from previous step, for mock we might not need it valid
  }) async {
    emit(const VerificationLoading());
    
    final result = await _verifyEmailUseCase(
      VerifyEmailParams(code: code, token: token),
    );

    result.fold(
      onFailure: (failure) => emit(VerificationFailure(failure.message)),
      onSuccess: (session) => emit(VerificationSuccess(session)),
    );
  }
}
