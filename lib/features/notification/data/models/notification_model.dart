// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/notification/domain/entities/entities.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
abstract class NotificationModel with _$NotificationModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory NotificationModel({
    required int id,
    required String uuid,
    required String title,
    required String message,
    String? sentAt,
    String? readAt,
    String? createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      uuid: entity.uuid,
      title: entity.title,
      message: entity.message,
      sentAt: entity.sentAt,
      readAt: entity.readAt,
      createdAt: entity.createdAt,
    );
  }
}

extension NotificationModelX on NotificationModel {
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      uuid: uuid,
      title: title,
      message: message,
      sentAt: sentAt,
      readAt: readAt,
      createdAt: createdAt,
    );
  }
}
