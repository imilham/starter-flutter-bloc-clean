import 'package:equatable/equatable.dart';
import 'notification_entity.dart';

class PaginationMetadata extends Equatable {
  const PaginationMetadata({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  bool get hasMorePages => currentPage < lastPage;

  @override
  List<Object?> get props => [currentPage, lastPage, perPage, total];
}

class NotificationsPaginatedEntity extends Equatable {
  const NotificationsPaginatedEntity({
    required this.items,
    required this.metadata,
  });

  final List<NotificationEntity> items;
  final PaginationMetadata metadata;

  @override
  List<Object?> get props => [items, metadata];
}
