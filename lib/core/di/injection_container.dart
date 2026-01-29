import 'package:hive_flutter/hive_flutter.dart';
import 'package:starter/core/di/core_injection.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/features/onboarding/onboarding.dart';
import 'package:starter/features/profile/profile.dart';
import 'package:starter/utils/utils.dart';

/// Returns the instance of the GetIt service locator.
///
/// The GetIt service locator is a singleton class that provides a convenient way to access
/// and manage dependencies in your application. This getter method returns the instance
/// of the GetIt service locator.
GetIt get getIt => GetIt.instance;

/// Sets up the application by registering necessary dependencies and initializing services.
///
/// The [environment] parameter specifies the application environment.
/// It registers classes as singletons using the GetIt service locator.
///
/// Registration order matters - core services first, then features in dependency order.
Future<void> setup({required AppEnvironment environment}) async {
  // 1. Core Services (AppSettings, AppStates, ApiClient, Theme, Router)
  await getIt.registerCoreServices(environment: environment);

  // 2. Auth Feature (DataSources, Repository, UseCases, BLoC/Cubits)
  await getIt.registerAuthFeature();

  // 3. Profile Feature (DataSource, Repository, UseCases, BLoC)
  // 4. Onboarding Feature (Repository, UseCase)
  getIt
    ..registerProfileFeature()
    ..registerOnboardingFeature();

  // Wait for all async registrations to complete
  await getIt.allReady();
}

/// Initializes Hive database for Flutter.
/// This function must be called before using any Hive functionality.
/// Returns a Future that completes when the initialization is done.
Future<void> hiveInit() async {
  await Hive.initFlutter();
}
