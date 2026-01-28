import 'package:flutter/material.dart';
import 'package:starter/app/app.dart';
import 'package:starter/utils/utils.dart';

/// Forgot password page - placeholder for BLoC migration.
/// TODO: Implement ForgotPasswordCubit when needed.
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  bool _isSubmitted = false;
  bool _isLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitForgotPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // TODO: Implement with ForgotPasswordCubit
      await Future<void>.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isSubmitted = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: _isLoading,
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
                    isLoading: _isLoading,
                    onPressed: _submitForgotPassword,
                  ),
                  const RelativeGap(mainAxisExtent: 0.02),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
