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

  String _countryCode = GetIt.instance<AppSettings>().countryCodes.first;
  bool _isPasswordVisible = false;
  
  final AuthService authService = GetIt.instance<AuthService>();

  /// Stream subscription for monitoring changes in the authentication state.
  late StreamSubscription<AuthState> _authStateSubscription;
  
  /// Initializes the state of the widget.
  /// Sets up the text controllers for email, password, and phone.
  /// Subscribes to the authentication state changes and calls the [onAuthStateChanged] method.
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
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
            title: const Text('Sign Up Failed'),
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
    _phoneController.dispose();
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
              title: const Text('Sign Up'),
            ),
            body: Form(
              key: _formKey,
              child: ExtendedColumn(
                children: [
                  const RelativeGap(mainAxisExtent: 0.05),
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
                  const FixedGap(mainAxisExtent: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      'Password',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const FixedGap(mainAxisExtent: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      'Mobile Number',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          value: _countryCode,
                          onChanged: (value) {
                            setState(() {
                              _countryCode = value!;
                            });
                          },
                          items: GetIt.instance<AppSettings>().countryCodes.map((countryCode) {
                            return DropdownMenuItem<String>(
                              value: countryCode,
                              child: Text(countryCode),
                            );
                          }).toList(),
                        ),
                      ),
                      const FixedGap(mainAxisExtent: 8),
                      Expanded(
                        flex: 6,
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            hintText: '1234567890',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const FixedGap(mainAxisExtent: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'By continuing, you agree to our ',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              // TODO(ishanga): Add Terms and Conditions page
                            },
                          ),
                          const TextSpan(text: ' Terms and Conditions and confirm you have read our '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              // TODO(ishanga): Add Privacy Policy page
                            },
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                  const FixedGap(mainAxisExtent: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authService.signUp(
                          _emailController.text,
                          _passwordController.text,
                          _countryCode + _phoneController.text,
                        );
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
                        return const Text('Verify Account');
                      },
                    ),
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
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Pages.signIn.go(context);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold)),
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
