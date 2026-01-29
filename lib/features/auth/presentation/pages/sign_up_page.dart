import 'package:check_disposable_email/check_disposable_email.dart' as check_email;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/features/auth/auth.dart';
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

  @override
  void initState() {
    _emailController = TextEditingController(text: 'john@elegantmedia.com.au');
    _passwordController = TextEditingController(text: '*******2222');
    _phoneController = TextEditingController(text: '0412345678');
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(registerUseCase: getIt<RegisterUseCase>()),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) async {
          if (state is SignUpFailure) {
            await CommonDialog.alert(
              context,
              title: context.l10n.signUpFailed,
              message: state.message,
            );
          } else if (state is SignUpSuccess) {
            // Notify global auth bloc that session was established
            getIt<AuthBloc>().add(AuthSessionEstablished(state.session));
          }
        },
        builder: (context, state) {
          final isLoading = state is SignUpLoading;
          return AbsorbPointer(
            absorbing: isLoading,
            child: Scaffold(
              appBar: CommonAppBar(
                title: context.l10n.signUp,
              ),
              body: Form(
                key: _formKey,
                child: ExtendedColumn(
                  children: [
                    const RelativeGap(mainAxisExtent: 0.05),
                    EmailFormField(
                      title: context.l10n.email,
                      controller: _emailController,
                      hintText: 'john@elegantmedia.com.au',
                    ),
                    Gap.medium16,
                    PasswordFormField(
                      title: context.l10n.password,
                      controller: _passwordController,
                      hintText: '*******',
                    ),
                    Gap.medium16,
                    PhoneFormField(
                      phoneNumberController: _phoneController,
                      phoneFocusNode: FocusNode(),
                    ),
                    Gap.large24,
                    RichText(
                      text: TextSpan(
                        text: context.l10n.agreeTo,
                        style: context.bodyMedium,
                        children: [
                          TextSpan(
                            text: context.l10n.termsOfService,
                            style: context.bodyMedium?.copyWith(
                              color: context.colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // TODO(ishanga): Add Terms and Conditions page
                              },
                          ),
                          TextSpan(text: context.l10n.termsAndPrivacyConfirm),
                          TextSpan(
                            text: context.l10n.privacyPolicy,
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
                    ).paddingHorizontal16,
                    Gap.large24,
                    CommonElevatedButton(
                      text: context.l10n.signUp,
                      isLoading: isLoading,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final isValid = check_email.Disposable.instance.hasValidEmail(_emailController.text);                          
                          if (!isValid) {
                            await CommonDialog.alert(
                              context,
                              title: context.l10n.invalidEmail,
                              message: context.l10n.disposableEmailError,
                            );
                            return;
                          }
                          if (!context.mounted) return;
                          await context.read<SignUpCubit>().signUp(
                                email: _emailController.text,
                                password: _passwordController.text,
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
                          context.l10n.orContinueWith,
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
                          context.l10n.alreadyHaveAccount,
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
                            context.l10n.signIn,
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
      ),
    );
  }
}
