import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pinput.dart';
import 'package:starter/auth/auth.dart';
import 'package:starter/utils/utils.dart';

class CodeVerificationPage extends StatefulWidget {
  const CodeVerificationPage({super.key});

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  final AuthService _authService = GetIt.instance<AuthService>();
  late final OTPTextEditController _codeController;

  /// Stream subscription for monitoring changes in the authentication state.
  late StreamSubscription<AuthState> _authStateSubscription;

  /// Initializes the state of the widget.
  /// Subscribes to the authentication state changes and calls the [onAuthStateChanged] method.
  @override
  void initState() {
    _codeController = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) {
        if (mounted) {
          _authService.verify(code);
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
    _authStateSubscription = _authService.onAuthStateChanges.listen(onAuthStateChanged);
    super.initState();
  }

  /// Callback function that is called when the authentication state changes.
  /// Shows an adaptive dialog with an error message if the authentication fails.
  /// The error message is obtained from the [AuthState] object.
  /// The dialog is dismissed when the user taps the 'OK' button.
  Future<void> onAuthStateChanged(AuthState state) async {
    if (state is AuthCodeVerificationFailed && mounted) {
      await CommonDialog.alert(
        context,
        title: 'Error',
        message: state.message,
      );
    } else if (state is AuthCodeResendFailed && mounted) {
      await CommonDialog.alert(
        context,
        title: 'Error',
        message: state.message,
      );
    }
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    _codeController.stopListen();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    return StreamBuilder<AuthState>(
      stream: _authService.onAuthStateChanges,
      builder: (context, snapshot) {
        final isLoading = snapshot.data is AuthLoading;
        return AbsorbPointer(
          absorbing: isLoading,
          child: Scaffold(
            appBar: CommonAppBar(
              title: 'Verification',
              actions: [
                TextButton(
                  onPressed: () async {
                    await _authService.logout();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: context.colorScheme.error,
                  ),
                  child: Text(
                    'Log Out',
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
                  'Please enter your verification code',
                  textAlign: TextAlign.center,
                  style: headline24(),
                ),
                Gap.medium16,
                Text(
                  'The verification code has been sent to sample@mail.com',
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
                  text: 'Sign In',
                  isLoading: isLoading,
                  onPressed: () async {
                    if (_codeController.text.isNotEmpty) {
                      await _authService.verify(_codeController.text);
                    }
                  },
                ),
                Gap.medium16,
                const Spacer(),
                Text(
                  "Didn't receive the verification code?",
                  textAlign: TextAlign.center,
                  style: bodyRegular16(),
                ),
                Gap.extraSmall4,
                TextButton(
                  onPressed: _authService.resendVerificationCode,
                  child: Text(
                    'Resend the Code',
                    style: bodyRegular16(fontWeight: FontWeight.bold),
                  ),
                ),
                Gap.medium16,
                Text(
                  'Or',
                  textAlign: TextAlign.center,
                  style: bodyRegular16(),
                ),
                Gap.medium16,
                Text(
                  'Send the verification code to your mobile number?',
                  textAlign: TextAlign.center,
                  style: bodyRegular16(),
                ),
                Gap.extraSmall4,
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Send the code',
                    style: bodyRegular16(fontWeight: FontWeight.bold),
                  ),
                ),
                const RelativeGap(mainAxisExtent: 0.02),
              ],
            ),
          ),
        );
      },
    );
  }
}
