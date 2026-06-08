import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:starter/features/notification/domain/domain.dart';
import 'package:starter/features/notification/notification_injection.dart';
import 'package:starter/features/notification/presentation/bloc/bloc.dart';
import 'package:starter/features/notification/presentation/widgets/widgets.dart';
import 'package:starter/utils/widgets/widgets.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _lastPage = 1;

  late final PagingController<int, NotificationEntity> _pagingController = PagingController<int, NotificationEntity>(
    getNextPageKey: (state) {
      final loadedPages = state.pages?.length ?? 0;
      if (loadedPages >= _lastPage) return null;
      return loadedPages + 1;
    },
    fetchPage: (pageKey) async {
      if (pageKey == 1) _lastPage = 1;
      final result = await getIt<FetchNotificationsUseCase>()(FetchNotificationsParams(page: pageKey));
      return result.fold(
          onFailure: (failure) => throw Exception(failure.message),
          onSuccess: (notifications) {
            _lastPage = notifications.metadata.lastPage;
            return notifications.items;
          },);
    },
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _showClearAllDialog,
          ),
        ],
      ),
      body: BlocListener<NotificationBloc, NotificationState>(
        listener: (context, state) {
          if (state is NotificationErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AllNotificationsDeletedState) {
            _pagingController.refresh();
          } else if (state is NotificationDeletedState || state is NotificationUpdatedState) {
            _pagingController.refresh();
          }
        },
        child: PagingListener(
          controller: _pagingController,
          builder: (context, state, fetchNextPage) => PagedListView<int, NotificationEntity>(
            state: state,
            fetchNextPage: fetchNextPage,
            builderDelegate: PagedChildBuilderDelegate<NotificationEntity>(
              itemBuilder: (context, notification, index) => NotificationItemWidget(
                notification: notification,
                onTap: () => _openNotificationDetails(context, notification),
                onMarkAsRead: () => _markAsRead(context, notification),
                onDelete: () => _deleteNotification(context, notification),
              ),
              noItemsFoundIndicatorBuilder: (context) => const CommonEmptyWidget(
                title: 'No notifications',
                iconData: Icons.notifications_none,
              ),
              firstPageErrorIndicatorBuilder: (context) => CommonErrorWidget(
                errorMessage: 'Failed to load notifications',
                onRetry: () => _pagingController.refresh(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openNotificationDetails(BuildContext context, NotificationEntity notification) {
    // TODO: Implement navigation to notification details
    // context.push('/notification/${notification.uuid}');
  }

  void _markAsRead(BuildContext context, NotificationEntity notification) {
    context.read<NotificationBloc>().add(MarkAsReadEvent(notification.uuid));
  }

  void _deleteNotification(BuildContext context, NotificationEntity notification) {
    context.read<NotificationBloc>().add(DeleteNotificationEvent(notification.uuid));
  }

  void _showClearAllDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<NotificationBloc>().add(const DeleteAllNotificationsEvent());
              Navigator.pop(context);
            },
            child: const Text('Delete All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}


