// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_paginated_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginationMetadataModel _$PaginationMetadataModelFromJson(
        Map<String, dynamic> json) =>
    _PaginationMetadataModel(
      currentPage: (json['current_page'] as num).toInt(),
      lastPage: (json['last_page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationMetadataModelToJson(
        _PaginationMetadataModel instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'total': instance.total,
    };

_NotificationsPaginatedModel _$NotificationsPaginatedModelFromJson(
        Map<String, dynamic> json) =>
    _NotificationsPaginatedModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: PaginationMetadataModel.fromJson(
          json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationsPaginatedModelToJson(
        _NotificationsPaginatedModel instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'metadata': instance.metadata.toJson(),
    };
