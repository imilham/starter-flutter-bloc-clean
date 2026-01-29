import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pinput.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/utils/utils.dart';

/// Code verification page - placeholder for BLoC migration.
// TODO(developer): Implement VerificationCubit when needed.
class CodeVerificationPage extends StatefulWidget {
  const CodeVerificationPage({super.key});

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  late final OTPTextEditController _codeController;

  @override
  void initState() {
    _codeController = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) {
        if (mounted) {
          // Optional: Auto-verify on receive
        }
      },
    );

    if (Platform.isAndroid) {
      _codeController.startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        },
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _codeController
      ..stopListen()
      ..dispose();
    super.dispose();
  }

  void _logout() {
    context.read<AuthBloc>().add(const AuthLogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationCubit(
        verifyEmailUseCase: getIt<VerifyEmailUseCase>(),
      ),
      child: BlocConsumer<VerificationCubit, VerificationState>(
        listener: (context, state) {
          if (state is VerificationSuccess) {
            getIt<AuthBloc>().add(AuthSessionEstablished(state.session));
          } else if (state is VerificationFailure) {
            CommonDialog.alert(
              context,
              title: context.l10n.error,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is VerificationLoading;

          final defaultPinTheme = PinTheme(
            width: 50,
            height: 50,
            textStyle: context.titleLarge?.copyWith(
              color: context.colorScheme.onSurface,
            ),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: AppRadius.small8,
            ),
          );
          final focusedPinTheme = defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: AppRadius.small8,
            ),
          );
          final submittedPinTheme = defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withValues(alpha: 0.2),
              borderRadius: AppRadius.small8,
              border: Border.all(color: context.colorScheme.primary, width: 2),
            ),
          );
          final followingPinTheme = defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: AppRadius.small8,
            ),
          );

          return AbsorbPointer(
            absorbing: isLoading,
            child: Scaffold(
              appBar: CommonAppBar(
                title: context.l10n.verification,
                actions: [
                  TextButton(
                    onPressed: _logout,
                    style: TextButton.styleFrom(
                      foregroundColor: context.colorScheme.error,
                    ),
                    child: Text(
                      context.l10n.logOut,
                      style: bodyRegular16(),
                    ),
                  ),
                ],
              ),
              body: ExtendedColumn(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const RelativeGap(mainAxisExtent: 0.05),
                  Text(
                    context.l10n.enterVerificationCode,
                    textAlign: TextAlign.center,
                    style: headline24(),
                  ),
                  Gap.medium16,
                  Text(
                    context.l10n.verificationCodeSent,
                    textAlign: TextAlign.center,
                    style: bodyRegular16(),
                  ),
                  Gap.extraLarge32,
                  Gap.medium16,
                  SizedBox(
                    width: double.infinity,
                    child: Pinput(
                      autofocus: true,
                      controller: _codeController,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      followingPinTheme: followingPinTheme,
                    ),
                  ),
                  Gap.extraLarge32,
                  Gap.medium16,
                  CommonElevatedButton(
                    text: context.l10n.verification,
                    isLoading: isLoading,
                    onPressed: () {
                      if (_codeController.text.isNotEmpty) {
                        context.read<VerificationCubit>().verifyEmail(
                              code: _codeController.text,
                              token: 'mock_token',
                            );
                      }
                    },
                  ),
                  Gap.medium16,
                  const Spacer(),
                  Text(
                    context.l10n.didntReceiveCode,
                    textAlign: TextAlign.center,
                    style: bodyRegular16(),
                  ),
                  Gap.extraSmall4,
                  TextButton(
                    onPressed: () {
                      // TODO(developer): Implement resend with Cubit
                    },
                    child: Text(
                      context.l10n.resendCode,
                      style: bodyRegular16(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Gap.medium16,
                  Text(
                    context.l10n.or,
                    textAlign: TextAlign.center,
                    style: bodyRegular16(),
                  ),
                  Gap.medium16,
                  Text(
                    context.l10n.sendCodeMobile,
                    textAlign: TextAlign.center,
                    style: bodyRegular16(),
                  ),
                  Gap.extraSmall4,
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      context.l10n.sendCode,
                      style: bodyRegular16(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const RelativeGap(mainAxisExtent: 0.02),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
