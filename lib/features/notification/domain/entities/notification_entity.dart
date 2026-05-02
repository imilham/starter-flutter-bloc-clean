import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  const NotificationEntity({
    required this.id,
    required this.uuid,
    required this.title,
    required this.message,
    this.sentAt,
    this.readAt,
    this.createdAt,
  });

  final int id;
  final String uuid;
  final String title;
  final String message;
  final String? sentAt;
  final String? readAt;
  final String? createdAt;

  bool get isRead => readAt != null;

  @override
  List<Object?> get props => [id, uuid, title, message, sentAt, readAt, createdAt];
}
