import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:starter/features/notification/domain/domain.dart';
import 'package:starter/features/notification/presentation/bloc/bloc.dart';
import 'package:starter/features/notification/notification_injection.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

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
          });
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
              noItemsFoundIndicatorBuilder: (context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.notifications_none, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'No notifications',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    const Text('Failed to load notifications'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _pagingController.refresh(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
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

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({
    Key? key,
    required this.notification,
    this.onTap,
    this.onMarkAsRead,
    this.onDelete,
  }) : super(key: key);

  final NotificationEntity notification;
  final VoidCallback? onTap;
  final VoidCallback? onMarkAsRead;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: notification.isRead
            ? null
            : Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              notification.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (notification.createdAt != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  notification.createdAt!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
          ],
        ),
        trailing: PopupMenuButton<void>(
          itemBuilder: (context) => [
            if (!notification.isRead)
              PopupMenuItem<void>(
                onTap: onMarkAsRead,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.done, size: 20),
                    SizedBox(width: 8),
                    Text('Mark as read'),
                  ],
                ),
              ),
            PopupMenuItem<void>(
              onTap: onDelete,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete, size: 20, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
