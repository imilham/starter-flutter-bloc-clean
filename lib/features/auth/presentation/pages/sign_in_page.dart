import 'package:check_disposable_email/check_disposable_email.dart' as check_email;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/app.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/features/auth/auth.dart';
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

  @override
  void initState() {
    _emailController = TextEditingController(text: 'john@elegantmedia.com.au');
    _passwordController = TextEditingController(text: '*******2222');
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(loginUseCase: getIt<LoginUseCase>()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginFailure) {
            await CommonDialog.alert(
              context,
              title: context.l10n.signInFailed,
              message: state.message,
            );
          } else if (state is LoginSuccess) {
            // Notify global auth bloc of successful login
            getIt<AuthBloc>().add(AuthLoginRequested(state.session));
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;
          return AbsorbPointer(
            absorbing: isLoading,
            child: Scaffold(
              appBar: CommonAppBar(
                title: context.l10n.signIn,
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
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            Pages.forgotPassword.go(context);
                          },
                          child: Text(
                            context.l10n.forgotPassword,
                            style: bodyRegular16(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Gap.medium16,
                    CommonElevatedButton(
                      text: context.l10n.signIn,
                      isLoading: isLoading,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final isValid = check_email.Disposable.instance.hasValidEmail(_emailController.text);
                          if (!isValid) {
                            await CommonDialog.alert(
                              context,
                              title: context.l10n.invalidEmail,
                              message: 'Please use a valid email address. Disposable emails are not allowed.',
                            );
                            return;
                          }
                          final deviceId = await getIt<AppSettings>().getDeviceId();
                          final deviceType = getIt<AppSettings>().getDevicePlatform();
                          if (!context.mounted) return;
                          await context.read<LoginCubit>().login(
                                email: _emailController.text,
                                password: _passwordController.text,
                                deviceId: deviceId,
                                deviceType: deviceType,
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
                          context.l10n.dontHaveAccount,
                          style: bodyRegular16(),
                        ),
                        TextButton(
                          onPressed: () {
                            Pages.signUp.go(context);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            context.l10n.signUp,
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
