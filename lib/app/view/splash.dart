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

  // ============================================================================
  // TODO: API-Implementation-8: Splash Screen Initialization
  // ============================================================================
  // WHAT THIS METHOD DOES:
  // - Initializes the app
  // - Checks for stored authentication session
  // - Optionally fetches app configuration from backend
  // - Navigates to appropriate screen (home/onboarding/auth)
  //
  // WHAT TO ADD (if needed by your backend):
  // 1. Fetch app configuration (e.g., feature flags, remote config)
  // 2. Check app version and force update if needed
  // 3. Fetch initial data required for the app
  //
  // HOW TO DO IT:
  // Replace or enhance the init() method below with:
  /*
  Future<void> init() async {
    FlutterNativeSplash.remove();
    
    // TODO: API-Implementation-8a - Fetch app configuration
    // If your backend provides app-level configuration, fetch it here
    try {
      final apiClient = getIt<ApiClient>();
      
      // Example: Fetch app configuration
      final configResponse = await apiClient.get('/config/app');
      // Parse and save config
      final config = AppConfig.fromJson(configResponse.data as Map<String, dynamic>);
      await getIt<AppStates>().updateConfig(config);
      
      // Example: Check minimum app version
      final versionResponse = await apiClient.get('/config/version');
      final minVersion = versionResponse.data['minimum_version'] as String;
      final currentVersion = await getIt<AppSettings>().appVersion;
      if (isUpdateRequired(currentVersion, minVersion)) {
        // Show force update dialog
        // return; // Don't proceed with normal flow
      }
    } catch (e) {
      // Handle errors gracefully - app should still work without backend config
      // ignore: avoid_print
      print('Failed to fetch app config: $e');
    }
    
    await getIt<AppStates>().onAppStart();

    // Check for stored session
    getIt<AuthBloc>().add(const AuthCheckRequested());

    getIt<AppStates>().isInitialized = true;
  }
  // */
  //
  // COMMON SPLASH SCREEN API CALLS:
  // - GET /config/app - App configuration (feature flags, settings)
  // - GET /config/version - Minimum supported version
  // - GET /content/announcements - Important announcements to show
  // - GET /user/subscriptions - User's subscription status
  //
  // NOTE: Keep the splash screen fast! Only fetch critical data here.
  // Non-critical data should be loaded after the user sees the main screen.
  // ============================================================================
  /// Initializes the application by delaying for 2 seconds
  /// and setting the `isInitialized` property of `AppStates` to true.
  Future<void> init() async {
    FlutterNativeSplash.remove();
    // TODO(ishanga): Remove the delay after actual API calls are implemented.
    // This is just to simulate a loading state.
    // TODO: API-Implementation-8 - Add app initialization API calls (see instructions above)
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
                        child: CircularProgressIndicator(),
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
