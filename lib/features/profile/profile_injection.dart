import 'package:starter/features/auth/auth.dart';
import 'package:starter/features/profile/profile.dart';
import 'package:starter/utils/utils.dart';

/// Extension on GetIt to register profile feature dependencies.
///
/// Registers data source, repository, use cases, and BLoC
/// for the profile feature.
extension ProfileInjection on GetIt {
  /// Registers all profile feature dependencies.
  void registerProfileFeature() {
    // Data Source
    // TODO(developer): Profile remote data source will also need ApiClient when implemented
    registerSingleton<ProfileRemoteDataSource>(ProfileRemoteDataSourceImpl());

    // Repository - depends on auth repository being ready
    registerSingletonWithDependencies<IProfileRepository>(
      () => ProfileRepositoryImpl(
        remoteDataSource: get<ProfileRemoteDataSource>(),
      ),
      dependsOn: [IAuthRepository],
    );

    // Use Cases (Factory - create new instances when needed)
    this
      ..registerFactory<UpdateProfileUseCase>(
        () => UpdateProfileUseCase(get<IProfileRepository>()),
      )
      ..registerFactory<GetProfileUseCase>(
        () => GetProfileUseCase(get<IProfileRepository>()),
      )
      ..registerFactory<DeleteProfileUseCase>(
        () => DeleteProfileUseCase(get<IProfileRepository>()),
      );

    // Profile BLoC (Factory - per-screen instance)
    registerFactory<ProfileBloc>(
      () => ProfileBloc(
        getProfileUseCase: get<GetProfileUseCase>(),
        updateProfileUseCase: get<UpdateProfileUseCase>(),
        deleteProfileUseCase: get<DeleteProfileUseCase>(),
      ),
    );
  }
}
