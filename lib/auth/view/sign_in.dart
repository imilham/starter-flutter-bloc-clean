import 'dart:async';

import 'package:flutter/material.dart';
import 'package:starter/app/app.dart';
import 'package:starter/auth/auth.dart';
import 'package:starter/utils/utils.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final AuthService authService = GetIt.instance<AuthService>();

  /// Stream subscription for monitoring changes in the authentication state.
  late StreamSubscription<AuthState> _authStateSubscription;

  /// Initializes the state of the widget.
  /// Sets up the text controllers for email, password, and phone.
  /// Subscribes to the authentication state changes and calls the [onAuthStateChanged] method.
  @override
  void initState() {
    _emailController = TextEditingController(text: 'john@elegantmedia.com.au');
    _passwordController = TextEditingController(text: '*******2222');
    _authStateSubscription = authService.onAuthStateChanges.listen(onAuthStateChanged);
    super.initState();
  }

  /// Callback function that is called when the authentication state changes.
  /// Shows an adaptive dialog with an error message if the authentication fails.
  /// The error message is obtained from the [AuthState] object.
  /// The dialog is dismissed when the user taps the 'OK' button.
  Future<void> onAuthStateChanged(AuthState state) async {
    if (state is AuthFailed && mounted) {
      await showAdaptiveDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Sign In Failed'),
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
    _emailController.dispose();
    _passwordController.dispose();
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
              title: const Text('Sign In'),
            ),
            body: Form(
              key: _formKey,
              child: ExtendedColumn(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    child: AppLogo(aspectRatio: 16 / 9),
                  ),
                  EmailFormField(
                    title: 'Email',
                    controller: _emailController,
                    hintText: 'john@elegantmedia.com.au',
                  ),
                  const FixedGap(mainAxisExtent: 16),
                  PasswordFormField(
                    title: 'Password',
                    controller: _passwordController,
                    hintText: '*******',
                  ),
                  const FixedGap(mainAxisExtent: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Pages.forgotPassword.go(context);
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                  ),
                  const FixedGap(mainAxisExtent: 16),
                  CommonElevatedButton.small(
                    text: 'Sign In',
                    isLoading: snapshot.data is AuthLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authService.login(
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                  ),
                  const FixedGap(mainAxisExtent: 48),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Or continue with',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  const FixedGap(mainAxisExtent: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: IconButton(
                          icon: const Icon(FontAwesomeIcons.apple),
                          onPressed: () {},
                        ),
                      ),
                      const FixedGap(mainAxisExtent: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: IconButton(
                          icon: const Icon(FontAwesomeIcons.google),
                          onPressed: () {},
                        ),
                      ),
                      const FixedGap(mainAxisExtent: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: IconButton(
                          icon: const Icon(FontAwesomeIcons.facebookF),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const FixedGap(mainAxisExtent: 16),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Pages.signUp.go(context);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                  const RelativeGap(mainAxisExtent: 0.02),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
