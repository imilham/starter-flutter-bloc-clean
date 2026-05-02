import 'package:starter/features/notification/data/models/models.dart';

abstract class NotificationRemoteDataSource {
  Future<NotificationsPaginatedModel> fetchNotifications({int page = 1});

  Future<NotificationModel> fetchNotificationById(String uuid);

  Future<NotificationModel> markAsRead(String uuid);

  Future<void> deleteNotification(String uuid);

  Future<void> deleteAllNotifications();

  Future<bool> getNotificationSettings();
}
