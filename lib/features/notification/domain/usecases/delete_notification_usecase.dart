import 'package:starter/core/core.dart';
import 'package:starter/features/notification/domain/repositories/notification_repository.dart';

class DeleteNotificationUseCase
    implements UseCase<void, DeleteNotificationParams> {
  DeleteNotificationUseCase(this.repository);

  final NotificationRepository repository;

  @override
  Future<Result<void>> call(DeleteNotificationParams params) async {
    return repository.deleteNotification(params.uuid);
  }
}

class DeleteNotificationParams {
  DeleteNotificationParams({required this.uuid});
  final String uuid;
}
