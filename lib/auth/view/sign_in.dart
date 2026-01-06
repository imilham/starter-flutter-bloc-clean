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
      await CommonDialog.alert(
        context,
        title: 'Sign In Failed',
        message: state.message,
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
        final isLoading = snapshot.data is AuthLoading;
        return AbsorbPointer(
          absorbing: isLoading,
          child: Scaffold(
            appBar: const CommonAppBar(
              title: 'Sign In',
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
                  Gap.medium16,
                  PasswordFormField(
                    title: 'Password',
                    controller: _passwordController,
                    hintText: '*******',
                  ),
                  Gap.medium16,
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Pages.forgotPassword.go(context);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: bodyRegular(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Gap.medium16,
                  CommonElevatedButton(
                    text: 'Sign In',
                    isLoading: isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authService.login(
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                  ),
                  Gap.extraLarge32,
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Or continue with',
                        style: bodyRegular(),
                      ),
                    ),
                  ),
                  Gap.medium16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.surface,
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: IconButton(
                          icon: const Icon(FontAwesomeIcons.apple),
                          onPressed: () {},
                        ),
                      ),
                      Gap.medium16,
                      Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.surface,
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: IconButton(
                          icon: const Icon(FontAwesomeIcons.google),
                          onPressed: () {},
                        ),
                      ),
                      Gap.medium16,
                      Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.surface,
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: IconButton(
                          icon: const Icon(FontAwesomeIcons.facebookF),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Gap.medium16,
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: bodyRegular(),
                      ),
                      TextButton(
                        onPressed: () {
                          Pages.signUp.go(context);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          'Sign Up',
                          style: bodyRegular(fontWeight: FontWeight.bold),
                        ),
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
