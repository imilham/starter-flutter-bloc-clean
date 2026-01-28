import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:starter/app/app.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/utils/utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
    super.initState();
  }

  /// Initializes the application by delaying for 2 seconds
  /// and setting the `isInitialized` property of `AppStates` to true.
  Future<void> init() async {
    FlutterNativeSplash.remove();
    // TODO(ishanga): Remove the delay after actual API calls are implemented.
    // This is just to simulate a loading state.
    await Future.delayed(const Duration(seconds: 2), () {});
    await getIt<AppStates>().onAppStart();

    // Check for stored session
    getIt<AuthBloc>().add(const AuthCheckRequested());

    getIt<AppStates>().isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: AppLogo(aspectRatio: 1.5),
            ),
            Gap.medium16,
            BlocBuilder<AuthBloc, AuthState>(
              bloc: getIt<AuthBloc>(),
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: CommonCircularLoader(),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
