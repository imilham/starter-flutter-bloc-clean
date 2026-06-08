import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:starter/core/core.dart';
import 'package:starter/features/notification/domain/domain.dart';
import 'package:starter/features/notification/presentation/bloc/notification_event.dart';
import 'package:starter/features/notification/presentation/bloc/notification_state.dart';

class NotificationBloc extends HydratedBloc<NotificationEvent, NotificationState> with PaginationMixin<NotificationEntity> {
  NotificationBloc({
    required this.fetchNotificationsUseCase,
    required this.fetchNotificationByIdUseCase,
    required this.markAsReadUseCase,
    required this.deleteNotificationUseCase,
    required this.deleteAllNotificationsUseCase,
    required this.getNotificationSettingsUseCase,
  }) : super(const NotificationInitialState()) {
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

  @override
  Future<({List<NotificationEntity> items, int lastPage})> fetchApi(int pageKey) async {
    final result = await fetchNotificationsUseCase(FetchNotificationsParams(page: pageKey));
    return result.fold(
      onFailure: (failure) => throw failure,
      onSuccess: (notifications) => (
        items: notifications.items,
        lastPage: notifications.metadata.lastPage,
      ),
    );
  }

  @override
  Future<void> close() {
    disposePagination();
    return super.close();
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
      // Refresh the list to show the updated state
      pagingController.refresh();
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
      // Refresh the list to remove the deleted item
      pagingController.refresh();
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
      pagingController.refresh();
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
    pagingController.refresh();
    emit(const NotificationsClearedState());
  }

  @override
  NotificationState? fromJson(Map<String, dynamic> json) {
    // We don't persist paginated data via HydratedBloc anymore as PagingController handles its own state
    // But we could persist settings if needed.
    return null;
  }

  @override
  Map<String, dynamic>? toJson(NotificationState state) {
    return null;
  }
}
