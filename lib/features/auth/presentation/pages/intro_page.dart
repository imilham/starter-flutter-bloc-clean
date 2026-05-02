import 'package:flutter/material.dart';
import 'package:starter/app/app.dart';
import 'package:starter/utils/utils.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedColumn(
        children: [
          const RelativeGap(mainAxisExtent: 0.2),
          const AppLogo(aspectRatio: 16 / 9),
          const RelativeGap(mainAxisExtent: 0.1),
          CommonButton.primary(
            onPressed: () {
              Pages.signUp.go(context);
            },
            label: context.l10n.introSignUp,
          ),
          const Spacer(),
          Gap.small8,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.l10n.alreadyHaveAccount,
                style: context.bodyRegular16(),
              ),
              TextButton(
                onPressed: () {
                  Pages.signIn.go(context);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  context.l10n.introSignIn,
                  style: context.bodyRegular16().semiBold,
                ),
              ),
            ],
          ),
          const RelativeGap(mainAxisExtent: 0.02),
        ],
      ),
    );
  }
}
