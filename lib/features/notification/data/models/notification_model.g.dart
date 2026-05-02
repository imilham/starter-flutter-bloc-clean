// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    _NotificationModel(
      id: (json['id'] as num).toInt(),
      uuid: json['uuid'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      sentAt: json['sent_at'] as String?,
      readAt: json['read_at'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(_NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'title': instance.title,
      'message': instance.message,
      'sent_at': instance.sentAt,
      'read_at': instance.readAt,
      'created_at': instance.createdAt,
    };
