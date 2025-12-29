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
      await showAdaptiveDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Request Failed'),
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
        return AbsorbPointer(
          absorbing: snapshot.data is AuthLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Forgot Password'),
            ),
            body: Builder(
              builder: (context) {
                if (_isSubmitted) {
                  return ExtendedColumn(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FixedGap(mainAxisExtent: 48),
                      Text(
                        'Please Check Your Email',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const FixedGap(mainAxisExtent: 16),
                      Text(
                        'A password reset link has been sent to your dedicated email',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const FixedGap(mainAxisExtent: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the email?",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isSubmitted = false;
                              });
                            },
                            child: Builder(
                              builder: (context) {
                                return const Text('Resend');
                              },
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
                        'Enter your registered email address below and we’ll send you a password reset email',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const FixedGap(mainAxisExtent: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child: Text(
                          'Email',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'me@example.com',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const FixedGap(mainAxisExtent: 24),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authService.forgotPassword(_emailController.text);
                          }
                        },
                        child: Builder(
                          builder: (context) {
                            if (snapshot.data is AuthLoading) {
                              return SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.6)),
                                ),
                              );
                            }
                            return const Text('Submit');
                          },
                        ),
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
