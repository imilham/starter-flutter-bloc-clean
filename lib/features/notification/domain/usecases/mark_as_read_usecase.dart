import 'package:starter/core/core.dart';
import 'package:starter/features/notification/domain/entities/entities.dart';
import 'package:starter/features/notification/domain/repositories/notification_repository.dart';

class MarkAsReadUseCase
    implements UseCase<NotificationEntity, MarkAsReadParams> {
  MarkAsReadUseCase(this.repository);

  final NotificationRepository repository;

  @override
  Future<Result<NotificationEntity>> call(MarkAsReadParams params) async {
    return repository.markAsRead(params.uuid);
  }
}

class MarkAsReadParams {
  MarkAsReadParams({required this.uuid});
  final String uuid;
}
