import 'package:starter/features/notification/data/data.dart';
import 'package:starter/features/notification/data/services/services.dart';
import 'package:starter/features/notification/domain/domain.dart';
import 'package:starter/features/notification/presentation/presentation.dart';
import 'package:starter/utils/utils.dart';

final getIt = GetIt.instance;

/// Register all notification-related dependencies
Future<void> setupNotificationInjection() async {
  // Services
  final pushNotificationService = PushNotificationService();
  getIt..registerSingleton<PushNotificationService>(pushNotificationService)

  // Data Sources
  ..registerSingleton<NotificationRemoteDataSource>(
    NotificationRemoteDataSourceImpl(networkClient: getIt<ApiClient>()),
  )

  // Repository
  ..registerSingleton<NotificationRepository>(
    NotificationRepositoryImpl(
      remoteDataSource: getIt<NotificationRemoteDataSource>(),
    ),
  )

  // Use Cases
  ..registerSingleton<FetchNotificationsUseCase>(
    FetchNotificationsUseCase(getIt<NotificationRepository>()),
  )

  ..registerSingleton<FetchNotificationByIdUseCase>(
    FetchNotificationByIdUseCase(getIt<NotificationRepository>()),
  )

  ..registerSingleton<MarkAsReadUseCase>(
    MarkAsReadUseCase(getIt<NotificationRepository>()),
  )

  ..registerSingleton<DeleteNotificationUseCase>(
    DeleteNotificationUseCase(getIt<NotificationRepository>()),
  )

  ..registerSingleton<DeleteAllNotificationsUseCase>(
    DeleteAllNotificationsUseCase(getIt<NotificationRepository>()),
  )

  ..registerSingleton<GetNotificationSettingsUseCase>(
    GetNotificationSettingsUseCase(getIt<NotificationRepository>()),
  )

  // BLoC
  ..registerFactory<NotificationBloc>(
    () => NotificationBloc(
      fetchNotificationsUseCase: getIt<FetchNotificationsUseCase>(),
      fetchNotificationByIdUseCase: getIt<FetchNotificationByIdUseCase>(),
      markAsReadUseCase: getIt<MarkAsReadUseCase>(),
      deleteNotificationUseCase: getIt<DeleteNotificationUseCase>(),
      deleteAllNotificationsUseCase: getIt<DeleteAllNotificationsUseCase>(),
      getNotificationSettingsUseCase: getIt<GetNotificationSettingsUseCase>(),
    ),
  );
}

/// Initialize push notification service
Future<void> initializePushNotifications() async {
  final pushNotificationService = getIt<PushNotificationService>();
  await pushNotificationService.initialize();
}
