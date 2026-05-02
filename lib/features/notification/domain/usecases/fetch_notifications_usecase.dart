import 'package:starter/core/core.dart';
import 'package:starter/features/notification/domain/entities/entities.dart';
import 'package:starter/features/notification/domain/repositories/notification_repository.dart';

class FetchNotificationsUseCase
    implements UseCase<NotificationsPaginatedEntity, FetchNotificationsParams> {
  FetchNotificationsUseCase(this.repository);

  final NotificationRepository repository;

  @override
  Future<Result<NotificationsPaginatedEntity>> call(
    FetchNotificationsParams params,
  ) async {
    return repository.fetchNotifications(page: params.page);
  }
}

class FetchNotificationsParams {
  FetchNotificationsParams({this.page = 1});
  final int page;
}
