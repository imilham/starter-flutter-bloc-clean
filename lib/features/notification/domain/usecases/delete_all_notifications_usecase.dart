import 'package:starter/core/core.dart';
import 'package:starter/features/notification/domain/repositories/notification_repository.dart';

class DeleteAllNotificationsUseCase implements UseCase<void, NoParams> {
  DeleteAllNotificationsUseCase(this.repository);

  final NotificationRepository repository;

  @override
  Future<Result<void>> call(NoParams params) async {
    return repository.deleteAllNotifications();
  }
}
