import 'package:starter/core/core.dart';
import 'package:starter/features/notification/domain/repositories/notification_repository.dart';

class GetNotificationSettingsUseCase implements UseCase<bool, NoParams> {
  GetNotificationSettingsUseCase(this.repository);

  final NotificationRepository repository;

  @override
  Future<Result<bool>> call(NoParams params) async {
    return repository.getNotificationSettings();
  }
}
