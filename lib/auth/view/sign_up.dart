import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:starter/auth/auth.dart';
import 'package:starter/utils/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _phoneController;

  final String _countryCode = GetIt.instance<AppSettings>().countryCodes.first;

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
    _phoneController = TextEditingController(text: '0412345678');
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
        title: 'Sign Up Failed',
        message: state.message,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
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
              title: 'Sign Up',
            ),
            body: Form(
              key: _formKey,
              child: ExtendedColumn(
                children: [
                  const RelativeGap(mainAxisExtent: 0.05),
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
                  PhoneFormField(
                    phoneNumberController: _phoneController,
                    phoneFocusNode: FocusNode(),
                  ),
                  Gap.large24,
                  Padding(
                    padding: AppSpacing.horizontalMd,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'By continuing, you agree to our ',
                        style: context.bodyMedium,
                        children: [
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: context.bodyMedium?.copyWith(
                              color: context.colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // TODO(ishanga): Add Terms and Conditions page
                              },
                          ),
                          const TextSpan(text: ' Terms and Conditions and confirm you have read our '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: context.bodyMedium?.copyWith(
                              color: context.colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // TODO(ishanga): Add Privacy Policy page
                              },
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                  Gap.large24,
                  CommonElevatedButton(
                    text: 'Verify Account',
                    isLoading: isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authService.signUp(
                          _emailController.text,
                          _passwordController.text,
                          _countryCode + _phoneController.text,
                        );
                      }
                    },
                  ),
                  Gap.extraLarge32,
                  Gap.medium16,
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Or continue with',
                        style: bodyRegular16(),
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
                        'Already have an account?',
                        style: bodyRegular16(),
                      ),
                      TextButton(
                        onPressed: () {
                          Pages.signIn.go(context);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          'Sign In',
                          style: bodyRegular16(fontWeight: FontWeight.bold),
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
