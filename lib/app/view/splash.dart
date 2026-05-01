import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:starter/app/app.dart';
import 'package:starter/app/controller/app_cubit.dart';
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

  /// Initializes the application.
  ///
  /// This method checks for an existing session, fetches the user profile,
  /// and sets up the initial application state.
  Future<void> init() async {
    FlutterNativeSplash.remove();

    // ========================================================================
    // TODO(api-implementation): Step 2 - Session Refresh & Profile Fetch
    // ========================================================================
    // GUIDELINES:
    // 1. AuthRefreshRequested triggers the RefreshSessionUseCase.
    // 2. The use case checks for stored session and fetches profile from API.
    // 3. If successful, AuthBloc emits AuthAuthenticated.
    // 4. If failed (no session or API error), AuthBloc emits AuthUnauthenticated.
    // ========================================================================

    await getIt<AppCubit>().onAppStart();

    final authBloc = getIt<AuthBloc>()
      // Trigger session refresh (fetches profile from API to validate session)
      ..add(const AuthRefreshRequested());

    // Wait for auth state to settle (not Loading/Initial)
    await authBloc.stream.firstWhere(
      (state) => state is AuthAuthenticated || state is AuthUnauthenticated,
    );

    getIt<AppCubit>().setInitialized(value: true);
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
                // if (state is AuthLoading) {
                //   return const Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       SizedBox(
                //         width: 24,
                //         height: 24,
                //         child: CircularProgressIndicator(),
                //       ),
                //     ],
                //   );
                // }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
