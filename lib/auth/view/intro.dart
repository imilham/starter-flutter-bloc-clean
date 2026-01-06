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
          CommonElevatedButton(
            onPressed: () {
              Pages.signUp.go(context);
            },
            text: 'Sign Up',
          ),
          const Spacer(),
          Gap.small8,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CommonText('Already have an account?').size14px,
              TextButton(
                onPressed: () {
                  Pages.signIn.go(context);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: const CommonText('Sign In').size14px.bold,
              ),
            ],
          ),
          const RelativeGap(mainAxisExtent: 0.02),
        ],
      ),
    );
  }
}
