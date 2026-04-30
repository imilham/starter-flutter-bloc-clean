import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/utils/utils.dart';

/// Extension on GetIt to register auth feature dependencies.
///
/// Registers data sources, repository, use cases, and BLoC/Cubits
/// for the authentication feature.
extension AuthInjection on GetIt {
  /// Registers all auth feature dependencies.
  Future<void> registerAuthFeature() async {
    // Data Sources
    registerSingletonAsync<AuthLocalDataSource>(() async {
      await Hive.openBox<String>(
        get<AppSettings>().sessionSecretKey,
        encryptionCipher: get<HiveAesCipher>(),
      );
      return AuthLocalDataSourceImpl();
    });

    registerSingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(apiClient: get<ApiClient>()),
    );

    // Repository
    registerSingletonWithDependencies<IAuthRepository>(
      () => AuthRepositoryImpl(
        localDataSource: get<AuthLocalDataSource>(),
        remoteDataSource: get<AuthRemoteDataSource>(),
      ),
      dependsOn: [AuthLocalDataSource],
    );

    // Use Cases
    this
      ..registerSingletonWithDependencies<GetStoredSessionUseCase>(
        () => GetStoredSessionUseCase(get<IAuthRepository>()),
        dependsOn: [IAuthRepository],
      )
      ..registerSingletonWithDependencies<LogoutUseCase>(
        () => LogoutUseCase(get<IAuthRepository>()),
        dependsOn: [IAuthRepository],
      )
      ..registerSingletonWithDependencies<LoginUseCase>(
        () => LoginUseCase(get<IAuthRepository>()),
        dependsOn: [IAuthRepository],
      )
      ..registerSingletonWithDependencies<RegisterUseCase>(
        () => RegisterUseCase(get<IAuthRepository>()),
        dependsOn: [IAuthRepository],
      )
      ..registerSingletonWithDependencies<VerifyEmailUseCase>(
        () => VerifyEmailUseCase(get<IAuthRepository>()),
        dependsOn: [IAuthRepository],
      )
      ..registerSingletonWithDependencies<RefreshSessionUseCase>(
        () => RefreshSessionUseCase(get<IAuthRepository>()),
        dependsOn: [IAuthRepository],
      )
      ..registerSingletonWithDependencies<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(get<IAuthRepository>()),
        dependsOn: [IAuthRepository],
      )
      ..registerSingletonWithDependencies<ResendVerificationCodeUseCase>(
        () => ResendVerificationCodeUseCase(get<IAuthRepository>()),
        dependsOn: [IAuthRepository],
      );

    // Auth BLoC - depends on multiple use cases
    registerSingletonWithDependencies<AuthBloc>(
      () => AuthBloc(
        getStoredSessionUseCase: get<GetStoredSessionUseCase>(),
        logoutUseCase: get<LogoutUseCase>(),
        refreshSessionUseCase: get<RefreshSessionUseCase>(),
      ),
      dependsOn: [GetStoredSessionUseCase, LogoutUseCase, RefreshSessionUseCase],
    );

    // Auth Cubits (Factory - per-screen instances)
    this
      ..registerFactory<LoginCubit>(
        () => LoginCubit(loginUseCase: get<LoginUseCase>()),
      )
      ..registerFactory<SignUpCubit>(
        () => SignUpCubit(registerUseCase: get<RegisterUseCase>()),
      )
      ..registerFactory<VerificationCubit>(
        () => VerificationCubit(verifyEmailUseCase: get<VerifyEmailUseCase>()),
      );
  }
}
