import 'package:equatable/equatable.dart';
import 'package:starter/features/notification/domain/domain.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitialState extends NotificationState {
  const NotificationInitialState();
}

class NotificationLoadingState extends NotificationState {
  const NotificationLoadingState();
}

class NotificationsLoadedState extends NotificationState {
  const NotificationsLoadedState(this.notifications);

  final NotificationsPaginatedEntity notifications;

  @override
  List<Object?> get props => [notifications];
}

class NotificationDetailLoadedState extends NotificationState {
  const NotificationDetailLoadedState(this.notification);

  final NotificationEntity notification;

  @override
  List<Object?> get props => [notification];
}

class NotificationUpdatedState extends NotificationState {
  const NotificationUpdatedState(this.notification);

  final NotificationEntity notification;

  @override
  List<Object?> get props => [notification];
}

class NotificationDeletedState extends NotificationState {
  const NotificationDeletedState(this.uuid);

  final String uuid;

  @override
  List<Object?> get props => [uuid];
}

class AllNotificationsDeletedState extends NotificationState {
  const AllNotificationsDeletedState();
}

class NotificationErrorState extends NotificationState {
  const NotificationErrorState(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class NotificationSettingsLoadedState extends NotificationState {
  const NotificationSettingsLoadedState(this.isEnabled);

  final bool isEnabled;

  @override
  List<Object?> get props => [isEnabled];
}

class PushNotificationReceivedState extends NotificationState {
  const PushNotificationReceivedState(this.title, this.body);

  final String title;
  final String body;

  @override
  List<Object?> get props => [title, body];
}

class NotificationsClearedState extends NotificationState {
  const NotificationsClearedState();
}
