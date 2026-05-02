import 'package:starter/core/core.dart';
import 'package:starter/features/notification/domain/entities/entities.dart';

abstract class NotificationRepository {
  Future<Result<NotificationsPaginatedEntity>> fetchNotifications({
    int page = 1,
  });

  Future<Result<NotificationEntity>> fetchNotificationById(String uuid);

  Future<Result<NotificationEntity>> markAsRead(String uuid);

  Future<Result<void>> deleteNotification(String uuid);

  Future<Result<void>> deleteAllNotifications();

  Future<Result<bool>> getNotificationSettings();
}
