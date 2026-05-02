// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/notification/data/models/notification_model.dart';
import 'package:starter/features/notification/domain/entities/entities.dart';

part 'notifications_paginated_model.freezed.dart';
part 'notifications_paginated_model.g.dart';

@freezed
abstract class PaginationMetadataModel with _$PaginationMetadataModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PaginationMetadataModel({
    required int currentPage,
    required int lastPage,
    required int perPage,
    required int total,
  }) = _PaginationMetadataModel;

  factory PaginationMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetadataModelFromJson(json);

  factory PaginationMetadataModel.fromEntity(PaginationMetadata entity) {
    return PaginationMetadataModel(
      currentPage: entity.currentPage,
      lastPage: entity.lastPage,
      perPage: entity.perPage,
      total: entity.total,
    );
  }
}

extension PaginationMetadataModelX on PaginationMetadataModel {
  PaginationMetadata toEntity() {
    return PaginationMetadata(
      currentPage: currentPage,
      lastPage: lastPage,
      perPage: perPage,
      total: total,
    );
  }
}

@freezed
abstract class NotificationsPaginatedModel with _$NotificationsPaginatedModel {
  @JsonSerializable(explicitToJson: true)
  const factory NotificationsPaginatedModel({
    required List<NotificationModel> items,
    required PaginationMetadataModel metadata,
  }) = _NotificationsPaginatedModel;

  factory NotificationsPaginatedModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsPaginatedModelFromJson(json);

  factory NotificationsPaginatedModel.fromEntity(NotificationsPaginatedEntity entity) {
    return NotificationsPaginatedModel(
      items: entity.items.map((e) => NotificationModel.fromEntity(e)).toList(),
      metadata: PaginationMetadataModel.fromEntity(entity.metadata),
    );
  }
}

extension NotificationsPaginatedModelX on NotificationsPaginatedModel {
  NotificationsPaginatedEntity toEntity() {
    return NotificationsPaginatedEntity(
      items: items.map((e) => e.toEntity()).toList(),
      metadata: metadata.toEntity(),
    );
  }
}
