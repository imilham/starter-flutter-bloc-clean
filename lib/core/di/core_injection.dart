import 'package:hive_flutter/hive_flutter.dart';
import 'package:starter/app/app.dart';
import 'package:starter/core/storage/storage.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/utils/utils.dart';
import 'package:starter/app/controller/router_notifier.dart';

/// Extension on GetIt to register core application services.
///
/// Core services include app settings, states, network client,
/// theme provider, and router.
extension CoreInjection on GetIt {
  /// Registers all core application dependencies.
  Future<void> registerCoreServices({
    required AppEnvironment environment,
    required HiveAesCipher hiveCipher,
  }) async {
    // App Settings & States
    this
      ..registerSingleton<AppSettings>(AppSettings(environment))
      ..registerSingleton<HiveAesCipher>(hiveCipher)
      ..registerSingleton<SecureStorage>(SecureStorageImpl())
      ..registerSingletonAsync<AppCubit>(() async {
        await Hive.openBox<bool>('states');
        return AppCubit();
      });

    // Network - API Client with Smart AuthInterceptor
    // Automatically adds auth tokens to all endpoints except public ones
    registerLazySingleton<ApiClient>(
      () => ApiClient(
        interceptors: [
          AuthInterceptor(), // Auto-adds tokens, skips login/register/forgot-password
          TokenExpirationInterceptor(), // Handles 401 Unauthorized
        ],
      ),
    );

    // Theme Service
    registerSingletonAsync<ThemeCubit>(() async {
      await Hive.openBox<bool>('themeMode');
      final isDark = Hive.box<bool>('themeMode').get('isDark') ?? false;
      ThemeService.setSystemUIOverlayStyle(isDark: isDark);
      return ThemeCubit(isDark: isDark);
    });

    // RouterNotifier bridge - depends on AppCubit
    registerSingletonWithDependencies<RouterNotifier>(
      () => RouterNotifier(GetIt.instance<AppCubit>()),
      dependsOn: [AppCubit],
    );

    // App Router - depends on AppCubit + RouterNotifier
    registerSingletonWithDependencies(AppRouter.new, dependsOn: [AppCubit, RouterNotifier]);
  }
}
