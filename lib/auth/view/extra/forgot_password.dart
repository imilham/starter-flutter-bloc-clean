import 'dart:async';

import 'package:flutter/material.dart';
import 'package:starter/app/app.dart';
import 'package:starter/auth/auth.dart';
import 'package:starter/utils/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;

  bool _isSubmitted = false;

  final AuthService authService = GetIt.instance<AuthService>();

  /// Stream subscription for monitoring changes in the authentication state.
  late StreamSubscription<AuthState> _authStateSubscription;

  /// Initializes the state of the widget.
  /// Sets up the text controllers for email, password, and phone.
  /// Subscribes to the authentication state changes and calls the [onAuthStateChanged] method.
  @override
  void initState() {
    _emailController = TextEditingController();
    _authStateSubscription = authService.onAuthStateChanges.listen(onAuthStateChanged);
    super.initState();
  }

  /// Callback function that is called when the authentication state changes.
  /// Shows an adaptive dialog with an error message if the authentication fails.
  /// The error message is obtained from the [AuthState] object.
  /// The dialog is dismissed when the user taps the 'OK' button.
  Future<void> onAuthStateChanged(AuthState state) async {
    if (state is AuthForgotPasswordSubmitFailed && mounted) {
      await CommonDialog.alert(
        context,
        title: context.l10n.requestFailed,
        message: state.message,
      );
    } else if (state is AuthForgotPasswordSubmitSuccess) {
      if (mounted) {
        setState(() {
          _isSubmitted = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: authService.onAuthStateChanges,
      builder: (context, snapshot) {
        final isLoading = snapshot.data is AuthLoading;
        return AbsorbPointer(
          absorbing: isLoading,
          child: Scaffold(
            appBar: CommonAppBar(
              title: context.l10n.forgotPassword,
            ),
            body: Builder(
              builder: (context) {
                if (_isSubmitted) {
                  return ExtendedColumn(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Gap.extraLarge32,
                      Gap.medium16,
                      Text(
                        context.l10n.checkEmail,
                        textAlign: TextAlign.center,
                        style: headline24(fontWeight: FontWeight.bold),
                      ),
                      Gap.medium16,
                      Text(
                        context.l10n.passwordResetSent,
                        textAlign: TextAlign.center,
                        style: bodyRegular16(),
                      ),
                      Gap.extraLarge32,
                      Gap.medium16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.l10n.didntReceiveEmail,
                            style: bodyRegular16(),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isSubmitted = false;
                              });
                            },
                            child: Text(
                              context.l10n.resend,
                              style: bodyRegular16(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const RelativeGap(mainAxisExtent: 0.02),
                    ],
                  );
                }
                return Form(
                  key: _formKey,
                  child: ExtendedColumn(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                        child: AppLogo(aspectRatio: 16 / 9),
                      ),
                      Text(
                        context.l10n.enterEmailReset,
                        style: bodyRegular16(),
                      ),
                      Gap.medium16,
                      EmailFormField(
                        title: context.l10n.email,
                        controller: _emailController,
                        hintText: 'me@example.com',
                      ),
                      Gap.large24,
                      CommonElevatedButton(
                        text: context.l10n.submit,
                        isLoading: isLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authService.forgotPassword(_emailController.text);
                          }
                        },
                      ),
                      const RelativeGap(mainAxisExtent: 0.02),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
