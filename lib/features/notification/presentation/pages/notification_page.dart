import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:starter/features/notification/domain/domain.dart';
import 'package:starter/features/notification/presentation/bloc/bloc.dart';
import 'package:starter/features/notification/presentation/widgets/widgets.dart';
import 'package:starter/utils/widgets/widgets.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => _showClearAllDialog(context),
          ),
        ],
      ),
      body: BlocListener<NotificationBloc, NotificationState>(
        listener: (context, state) {
          if (state is NotificationErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AllNotificationsDeletedState || state is NotificationDeletedState || state is NotificationUpdatedState) {
            context.read<NotificationBloc>().pagingController.refresh();
          }
        },
        child: PagingListener(
          controller: context.read<NotificationBloc>().pagingController,
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
                onRetry: () => context.read<NotificationBloc>().pagingController.refresh(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openNotificationDetails(BuildContext context, NotificationEntity notification) {
    // TODO: Implement navigation to notification details
  }

  void _markAsRead(BuildContext context, NotificationEntity notification) {
    context.read<NotificationBloc>().add(MarkAsReadEvent(notification.uuid));
  }

  void _deleteNotification(BuildContext context, NotificationEntity notification) {
    context.read<NotificationBloc>().add(DeleteNotificationEvent(notification.uuid));
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear All Notifications?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<NotificationBloc>().add(const DeleteAllNotificationsEvent());
              Navigator.pop(dialogContext);
            },
            child: const Text('Delete All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}


