import 'package:starter/features/notification/data/data.dart';
import 'package:starter/features/notification/data/services/services.dart';
import 'package:starter/features/notification/domain/domain.dart';
import 'package:starter/features/notification/presentation/presentation.dart';
import 'package:starter/utils/utils.dart';

/// Extension on GetIt to register notification feature dependencies.
extension NotificationInjection on GetIt {
  /// Registers all notification-related dependencies
  void registerNotificationFeature() {
    // Services
    final pushNotificationService = PushNotificationService();
    this..registerSingleton<PushNotificationService>(pushNotificationService)

    // Data Sources
    ..registerSingleton<NotificationRemoteDataSource>(
      NotificationRemoteDataSourceImpl(networkClient: get<ApiClient>()),
    )

    // Repository
    ..registerSingleton<NotificationRepository>(
      NotificationRepositoryImpl(
        remoteDataSource: get<NotificationRemoteDataSource>(),
      ),
    )

    // Use Cases
    ..registerSingleton<FetchNotificationsUseCase>(
      FetchNotificationsUseCase(get<NotificationRepository>()),
    )

    ..registerSingleton<FetchNotificationByIdUseCase>(
      FetchNotificationByIdUseCase(get<NotificationRepository>()),
    )

    ..registerSingleton<MarkAsReadUseCase>(
      MarkAsReadUseCase(get<NotificationRepository>()),
    )

    ..registerSingleton<DeleteNotificationUseCase>(
      DeleteNotificationUseCase(get<NotificationRepository>()),
    )

    ..registerSingleton<DeleteAllNotificationsUseCase>(
      DeleteAllNotificationsUseCase(get<NotificationRepository>()),
    )

    ..registerSingleton<GetNotificationSettingsUseCase>(
      GetNotificationSettingsUseCase(get<NotificationRepository>()),
    )

    // BLoC
    ..registerFactory<NotificationBloc>(
      () => NotificationBloc(
        fetchNotificationsUseCase: get<FetchNotificationsUseCase>(),
        fetchNotificationByIdUseCase: get<FetchNotificationByIdUseCase>(),
        markAsReadUseCase: get<MarkAsReadUseCase>(),
        deleteNotificationUseCase: get<DeleteNotificationUseCase>(),
        deleteAllNotificationsUseCase: get<DeleteAllNotificationsUseCase>(),
        getNotificationSettingsUseCase: get<GetNotificationSettingsUseCase>(),
      ),
    );
  }

  /// Initialize push notification service
  Future<void> initializePushNotifications() async {
    final pushNotificationService = get<PushNotificationService>();
    await pushNotificationService.initialize();
  }
}
