import 'package:hive_flutter/hive_flutter.dart';
import 'package:starter/app/app.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/utils/utils.dart';

/// Extension on GetIt to register core application services.
///
/// Core services include app settings, states, network client,
/// theme provider, and router.
extension CoreInjection on GetIt {
  /// Registers all core application dependencies.
  Future<void> registerCoreServices({required AppEnvironment environment}) async {
    // App Settings & States
    this
      ..registerSingleton<AppSettings>(AppSettings(environment))
      ..registerSingletonAsync<AppStates>(() async {
        await Hive.openBox<bool>('states');
        return AppStates();
      });

    // Network - API Client with Smart AuthInterceptor
    // Automatically adds auth tokens to all endpoints except public ones
    registerLazySingleton<ApiClient>(
      () => ApiClient(
        interceptors: [
          AuthInterceptor(), // Auto-adds tokens, skips login/register/forgot-password
        ],
      ),
    );

    // Theme Service
    registerSingletonAsync<ThemeServiceProvider>(() async {
      await Hive.openBox<bool>('themeMode');
      final isDark = Hive.box<bool>('themeMode').get('isDark') ?? false;
      ThemeServiceProvider.setSystemUIOverlayStyle(isDark: isDark);
      return ThemeServiceProvider(isDark: isDark);
    });

    // App Router - depends on AppStates
    registerSingletonWithDependencies(AppRouter.new, dependsOn: [AppStates]);
  }
}
