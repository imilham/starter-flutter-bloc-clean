import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starter/app/app.dart';
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

/// Boots up the application by initializing necessary components and running the provided builder function.
///
/// The [builder] function is responsible for creating the root widget of the application.
/// The [environment] parameter specifies the environment in which the application is running.
/// This function sets up error handling, initializes Flutter bindings, and registers singletons for various services.
Future<void> bootstrap(FutureOr<Widget> Function() builder, {required AppEnvironment environment}) async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Center(
        child: Builder(
          builder: (context) {
            return Text(
              context.l10n.genericError,
              style: bodyRegular16(textColor: Colors.red),
            );
          },
        ),
      ),
    );
  };

  FlutterError.onError = (details) {
    debugPrintStack(stackTrace: details.stack, label: details.exceptionAsString(), maxFrames: 10);
  };
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await hiveInit();
  await setup(environment: environment);
  runApp(await builder());
}

/// Sets up the application by registering necessary dependencies and initializing services.
///
/// The [environment] parameter specifies the application environment.
/// It registers the Classes as singletons using the GetIt service locator.
Future<void> setup({required AppEnvironment environment}) async {
  getIt
    ..registerSingleton<AppSettings>(AppSettings(environment))
    ..registerSingletonAsync<AppStates>(() async {
      await Hive.openBox<bool>('states');
      return AppStates();
    })
    // Network - API Client with Smart AuthInterceptor
    // Automatically adds auth tokens to all endpoints except public ones
    ..registerLazySingleton<ApiClient>(
      () => ApiClient(
        interceptors: [
          AuthInterceptor(), // Auto-adds tokens, skips login/register/forgot-password
        ],
      ),
    )
    // Auth Feature - BLoC and dependencies
    ..registerSingletonAsync<AuthLocalDataSource>(() async {
      await Hive.openBox<String>(getIt<AppSettings>().sessionSecretKey);
      return AuthLocalDataSourceImpl();
    })    
    ..registerSingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(apiClient: getIt<ApiClient>()),
    )
    ..registerSingletonWithDependencies<IAuthRepository>(
      () => AuthRepositoryImpl(
        localDataSource: getIt<AuthLocalDataSource>(),
        remoteDataSource: getIt<AuthRemoteDataSource>(),
      ),
      dependsOn: [AuthLocalDataSource],
    )
    ..registerSingletonWithDependencies<GetStoredSessionUseCase>(
      () => GetStoredSessionUseCase(getIt<IAuthRepository>()),
      dependsOn: [IAuthRepository],
    )
    ..registerSingletonWithDependencies<LogoutUseCase>(
      () => LogoutUseCase(getIt<IAuthRepository>()),
      dependsOn: [IAuthRepository],
    )
    ..registerSingletonWithDependencies<LoginUseCase>(
      () => LoginUseCase(getIt<IAuthRepository>()),
      dependsOn: [IAuthRepository],
    )
    ..registerSingletonWithDependencies<RegisterUseCase>(
      () => RegisterUseCase(getIt<IAuthRepository>()),
      dependsOn: [IAuthRepository],
    )
    ..registerSingletonWithDependencies<VerifyEmailUseCase>(
      () => VerifyEmailUseCase(getIt<IAuthRepository>()),
      dependsOn: [IAuthRepository],
    )
    ..registerSingletonWithDependencies<RefreshSessionUseCase>(
      () => RefreshSessionUseCase(getIt<IAuthRepository>()),
      dependsOn: [IAuthRepository],
    )
    ..registerSingletonWithDependencies<AuthBloc>(
      () => AuthBloc(
        getStoredSessionUseCase: getIt<GetStoredSessionUseCase>(),
        logoutUseCase: getIt<LogoutUseCase>(),
        refreshSessionUseCase: getIt<RefreshSessionUseCase>(),
      ),
      dependsOn: [GetStoredSessionUseCase, LogoutUseCase, RefreshSessionUseCase],
    )
    ..registerSingletonWithDependencies(AppRouter.new, dependsOn: [AppStates])
    ..registerSingletonAsync<ThemeServiceProvider>(() async {
      await Hive.openBox<bool>('themeMode');
      final isDark = Hive.box<bool>('themeMode').get('isDark') ?? false;
      ThemeServiceProvider.setSystemUIOverlayStyle(isDark: isDark);
      return ThemeServiceProvider(isDark: isDark);
    })
    // Profile Feature
    // TODO(developer): Profile remote data source will also need ApiClient when implemented
    ..registerSingleton<ProfileRemoteDataSource>(ProfileRemoteDataSourceImpl())
    ..registerSingletonWithDependencies<IProfileRepository>(
      () => ProfileRepositoryImpl(
        remoteDataSource: getIt<ProfileRemoteDataSource>(),
      ),
      dependsOn: [IAuthRepository],
    )
    ..registerFactory<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(getIt<IProfileRepository>()),
    )
    ..registerFactory<GetProfileUseCase>(
      () => GetProfileUseCase(getIt<IProfileRepository>()),
    )
    ..registerFactory<DeleteProfileUseCase>(
      () => DeleteProfileUseCase(getIt<IProfileRepository>()),
    )
    ..registerFactory<ProfileBloc>(
      () => ProfileBloc(
        getProfileUseCase: getIt<GetProfileUseCase>(),
        updateProfileUseCase: getIt<UpdateProfileUseCase>(),
        deleteProfileUseCase: getIt<DeleteProfileUseCase>(),
      ),
    )
    // Onboarding Feature - Separate from Profile
    ..registerLazySingleton<IOnboardingRepository>(
      () => OnboardingRepositoryImpl(getIt<IProfileRepository>()),
    )
    ..registerFactory<CompleteOnboardingUseCase>(
      () => CompleteOnboardingUseCase(getIt<IOnboardingRepository>()),
    );

  await getIt.allReady();
}

/// Initializes Hive database for Flutter.
/// This function must be called before using any Hive functionality.
/// Returns a Future that completes when the initialization is done.
Future<void> hiveInit() async {
  await Hive.initFlutter();
}
