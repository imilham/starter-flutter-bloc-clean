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
        title: 'Request Failed',
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
            appBar: const CommonAppBar(
              title: 'Forgot Password',
            ),
            body: Builder(
              builder: (context) {
                if (_isSubmitted) {
                  return ExtendedColumn(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Gap.extraLarge32,
                      Gap.medium16,
                      const CommonText(
                        'Please Check Your Email',
                        textAlign: TextAlign.center,
                      ).size24px.bold,
                      Gap.medium16,
                      const CommonText(
                        'A password reset link has been sent to your dedicated email',
                        textAlign: TextAlign.center,
                      ).size16px,
                      Gap.extraLarge32,
                      Gap.medium16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CommonText(
                            "Didn't receive the email?",
                          ).size14px,
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isSubmitted = false;
                              });
                            },
                            child: const CommonText('Resend').size14px.bold,
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
                      const CommonText(
                        "Enter your registered email address below and we'll send you a password reset email",
                      ).size16px,
                      Gap.medium16,
                      EmailFormField(
                        title: 'Email',
                        controller: _emailController,
                        hintText: 'me@example.com',
                      ),
                      Gap.large24,
                      CommonElevatedButton(
                        text: 'Submit',
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
