import 'package:starter/core/core.dart';
import 'package:starter/features/notification/domain/entities/entities.dart';
import 'package:starter/features/notification/domain/repositories/notification_repository.dart';

class FetchNotificationByIdUseCase
    implements UseCase<NotificationEntity, FetchNotificationByIdParams> {
  FetchNotificationByIdUseCase(this.repository);

  final NotificationRepository repository;

  @override
  Future<Result<NotificationEntity>> call(
    FetchNotificationByIdParams params,
  ) async {
    return repository.fetchNotificationById(params.uuid);
  }
}

class FetchNotificationByIdParams {
  FetchNotificationByIdParams({required this.uuid});
  final String uuid;
}
