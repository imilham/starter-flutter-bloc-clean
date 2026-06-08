import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:starter/core/core.dart';
import 'package:starter/features/notification/data/models/models.dart';
import 'package:starter/features/notification/domain/domain.dart';
import 'package:starter/features/notification/presentation/bloc/notification_event.dart';
import 'package:starter/features/notification/presentation/bloc/notification_state.dart';

class NotificationBloc extends HydratedBloc<NotificationEvent, NotificationState> {
  NotificationBloc({
    required this.fetchNotificationsUseCase,
    required this.fetchNotificationByIdUseCase,
    required this.markAsReadUseCase,
    required this.deleteNotificationUseCase,
    required this.deleteAllNotificationsUseCase,
    required this.getNotificationSettingsUseCase,
  }) : super(const NotificationInitialState()) {
    on<FetchNotificationsEvent>(_onFetchNotifications);
    on<FetchNotificationByIdEvent>(_onFetchNotificationById);
    on<MarkAsReadEvent>(_onMarkAsRead);
    on<DeleteNotificationEvent>(_onDeleteNotification);
    on<DeleteAllNotificationsEvent>(_onDeleteAllNotifications);
    on<GetNotificationSettingsEvent>(_onGetNotificationSettings);
    on<OnIncomingPushNotificationEvent>(_onIncomingPushNotification);
    on<ClearNotificationsEvent>(_onClearNotifications);
  }

  final FetchNotificationsUseCase fetchNotificationsUseCase;
  final FetchNotificationByIdUseCase fetchNotificationByIdUseCase;
  final MarkAsReadUseCase markAsReadUseCase;
  final DeleteNotificationUseCase deleteNotificationUseCase;
  final DeleteAllNotificationsUseCase deleteAllNotificationsUseCase;
  final GetNotificationSettingsUseCase getNotificationSettingsUseCase;

  /// Current notifications in memory (for accumulating paginated results)
  NotificationsPaginatedEntity? _currentNotifications;

  Future<void> _onFetchNotifications(
    FetchNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    if (event.page == 1) {
      emit(const NotificationLoadingState());
    }

    final result = await fetchNotificationsUseCase(FetchNotificationsParams(page: event.page));

    result.fold(onFailure: (failure) {
      emit(NotificationErrorState(failure.message));
    }, onSuccess: (notifications) {
      // For page 1, replace the list; for subsequent pages, append
      if (event.page == 1) {
        _currentNotifications = notifications;
      } else {
        if (_currentNotifications != null) {
          final combinedItems = [
            ..._currentNotifications!.items,
            ...notifications.items,
          ];
          _currentNotifications = NotificationsPaginatedEntity(
            items: combinedItems,
            metadata: notifications.metadata,
          );
        } else {
          _currentNotifications = notifications;
        }
      }

      emit(NotificationsLoadedState(_currentNotifications!));
    },);
  }

  Future<void> _onFetchNotificationById(
    FetchNotificationByIdEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoadingState());

    final result = await fetchNotificationByIdUseCase(
      FetchNotificationByIdParams(uuid: event.uuid),
    );

    result.fold(onFailure: (failure) {
      emit(NotificationErrorState(failure.message));
    }, onSuccess: (notification) {
      emit(NotificationDetailLoadedState(notification));
    },);
  }

  Future<void> _onMarkAsRead(
    MarkAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await markAsReadUseCase(MarkAsReadParams(uuid: event.uuid));

    result.fold(onFailure: (failure) {
      emit(NotificationErrorState(failure.message));
    }, onSuccess: (notification) {
      // Update the notification in the current list
      if (_currentNotifications != null) {
        final index = _currentNotifications!.items.indexWhere((item) => item.uuid == notification.uuid);
        if (index != -1) {
          final updatedItems = [..._currentNotifications!.items];
          updatedItems[index] = notification;
          _currentNotifications = NotificationsPaginatedEntity(
            items: updatedItems,
            metadata: _currentNotifications!.metadata,
          );
          emit(NotificationsLoadedState(_currentNotifications!));
        }
      }

      emit(NotificationUpdatedState(notification));
    },);
  }

  Future<void> _onDeleteNotification(
    DeleteNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await deleteNotificationUseCase(
      DeleteNotificationParams(uuid: event.uuid),
    );

    result.fold(onFailure: (failure) {
      emit(NotificationErrorState(failure.message));
    }, onSuccess: (_) {
      // Remove from current list
      if (_currentNotifications != null) {
        final updatedItems = _currentNotifications!.items.where((item) => item.uuid != event.uuid).toList();
        _currentNotifications = NotificationsPaginatedEntity(
          items: updatedItems,
          metadata: _currentNotifications!.metadata,
        );
        emit(NotificationsLoadedState(_currentNotifications!));
      }

      emit(NotificationDeletedState(event.uuid));
    },);
  }

  Future<void> _onDeleteAllNotifications(
    DeleteAllNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoadingState());

    final result = await deleteAllNotificationsUseCase(const NoParams());

    result.fold(onFailure: (failure) {
      emit(NotificationErrorState(failure.message));
    }, onSuccess: (_) {
      _currentNotifications = null;
      emit(const AllNotificationsDeletedState());
    },);
  }

  Future<void> _onGetNotificationSettings(
    GetNotificationSettingsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await getNotificationSettingsUseCase(const NoParams());

    result.fold(onFailure: (failure) {
      emit(NotificationErrorState(failure.message));
    }, onSuccess: (isEnabled) {
      emit(NotificationSettingsLoadedState(isEnabled));
    },);
  }

  Future<void> _onIncomingPushNotification(
    OnIncomingPushNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final title = event.message.notification?.title ?? '';
    final body = event.message.notification?.body ?? '';
    emit(PushNotificationReceivedState(title, body));
  }

  Future<void> _onClearNotifications(
    ClearNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    _currentNotifications = null;
    emit(const NotificationsClearedState());
  }

  @override
  NotificationState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['notifications'] != null) {
        final notificationsModel = NotificationsPaginatedModel.fromJson(json['notifications'] as Map<String, dynamic>);
        final notifications = notificationsModel.toEntity();
        _currentNotifications = notifications;
        return NotificationsLoadedState(notifications);
      }
    } catch (_) {
      // Ignored
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(NotificationState state) {
    if (state is NotificationsLoadedState) {
      return {
        'notifications': NotificationsPaginatedModel.fromEntity(state.notifications).toJson(),
      };
    }
    if (_currentNotifications != null) {
      return {
        'notifications': NotificationsPaginatedModel.fromEntity(_currentNotifications!).toJson(),
      };
    }
    return null;
  }
}
