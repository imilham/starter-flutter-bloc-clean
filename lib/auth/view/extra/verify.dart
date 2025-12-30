import 'dart:async';

import 'package:flutter/material.dart';
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
  late final TextEditingController _codeController;

  /// Stream subscription for monitoring changes in the authentication state.
  late StreamSubscription<AuthState> _authStateSubscription;

  /// Initializes the state of the widget.
  /// Subscribes to the authentication state changes and calls the [onAuthStateChanged] method.
  @override
  void initState() {
    _codeController = TextEditingController();
    _authStateSubscription = _authService.onAuthStateChanges.listen(onAuthStateChanged);
    super.initState();
  }

  /// Callback function that is called when the authentication state changes.
  /// Shows an adaptive dialog with an error message if the authentication fails.
  /// The error message is obtained from the [AuthState] object.
  /// The dialog is dismissed when the user taps the 'OK' button.
  Future<void> onAuthStateChanged(AuthState state) async {
    if (state is AuthCodeVerificationFailed && mounted) {
      await showAdaptiveDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(state.message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (state is AuthCodeResendFailed) {
      await showAdaptiveDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(state.message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
      ),
    );
    final followingPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return StreamBuilder<AuthState>(
      stream: _authService.onAuthStateChanges,
      builder: (context, snapshot) {
        return AbsorbPointer(
          absorbing: snapshot.data is AuthLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Verification'),
              actions: [
                TextButton(
                  onPressed: () async {
                    await _authService.logout();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                  child: const Text('Log Out'),
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
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const FixedGap(mainAxisExtent: 16),
                Text(
                  'The verification code has been sent to sample@mail.com',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const FixedGap(mainAxisExtent: 48),
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
                const FixedGap(mainAxisExtent: 48),
                CommonElevatedButton(
                  text: 'Sign In',
                  isLoading: snapshot.data is AuthLoading,
                  onPressed: () async {
                    if (_codeController.text.isNotEmpty) {
                      await _authService.verify(_codeController.text);
                    }
                  },
                ),
                const FixedGap(mainAxisExtent: 16),
                const Spacer(),
                Text(
                  'Didn’t receive the verification code?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const FixedGap(mainAxisExtent: 4),
                TextButton(
                  onPressed: _authService.resendVerificationCode,
                  child: const Text('Resend the Code'),
                ),
                const FixedGap(mainAxisExtent: 16),
                Text(
                  'Or',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const FixedGap(mainAxisExtent: 16),
                Text(
                  'Send the verification code to your mobile number?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const FixedGap(mainAxisExtent: 4),
                TextButton(
                  onPressed: () {},
                  child: const Text('Send the code'),
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
