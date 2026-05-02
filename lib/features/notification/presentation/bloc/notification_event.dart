import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class FetchNotificationsEvent extends NotificationEvent {
  const FetchNotificationsEvent({this.page = 1});

  final int page;

  @override
  List<Object?> get props => [page];
}

class FetchNotificationByIdEvent extends NotificationEvent {
  const FetchNotificationByIdEvent(this.uuid);

  final String uuid;

  @override
  List<Object?> get props => [uuid];
}

class MarkAsReadEvent extends NotificationEvent {
  const MarkAsReadEvent(this.uuid);

  final String uuid;

  @override
  List<Object?> get props => [uuid];
}

class DeleteNotificationEvent extends NotificationEvent {
  const DeleteNotificationEvent(this.uuid);

  final String uuid;

  @override
  List<Object?> get props => [uuid];
}

class DeleteAllNotificationsEvent extends NotificationEvent {
  const DeleteAllNotificationsEvent();
}

class GetNotificationSettingsEvent extends NotificationEvent {
  const GetNotificationSettingsEvent();
}

class OnIncomingPushNotificationEvent extends NotificationEvent {
  const OnIncomingPushNotificationEvent(this.message);

  final RemoteMessage message;

  @override
  List<Object?> get props => [message];
}

class ClearNotificationsEvent extends NotificationEvent {
  const ClearNotificationsEvent();
}
