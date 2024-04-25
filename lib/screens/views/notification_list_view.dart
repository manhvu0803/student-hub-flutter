import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client.dart' as client;
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/widgets.dart';
import 'package:student_hub_flutter/models.dart' as models;

class NotificationListView extends StatefulWidget {
  const NotificationListView({super.key});

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshableFutureBuilder.forCollection(
        emptyString: "No new notifications",
        fetcher: () => client.getNotifications(),
        builder: (context, data) => ListView(
          children: _getNotificationCards(context, data),
        ),
      ),
    );
  }

  List<Widget> _getNotificationCards(BuildContext context, Iterable<models.Notification> notifications) {
    return notifications.mapToList((notification) => _NotificationCard.fromNotification(
      notification,
      bottom: _getCardBottom(context, notification.type),
      onPressed: () => _onNotificationPressed(context, notification),
    ));
  }

  Widget? _getCardBottom(BuildContext context, models.NotificationType notificationType) {
    return switch (notificationType) {
      models.NotificationType.interview => ElevatedButton(
        onPressed: () {},
        child: const Text("Join"),
      ),
      models.NotificationType.offer => ElevatedButton(
        onPressed: () {},
        child: const Text("View project"),
      ),
      _ => null
    };
  }

  Future<void> _onNotificationPressed(BuildContext context, models.Notification notification) async {
    try {
      await client.readNotification(notification.id);
      notification.isRead = true;
    }
    catch (e) {
      if (context.mounted) {
        context.showTextSnackBar(e.toString());
      }
    }
  }
}

class _NotificationCard extends StatefulWidget {
  static Widget _getLeading(models.NotificationType notificationType) {
    return switch (notificationType) {
      models.NotificationType.interview => const Icon(Icons.event_available),
      models.NotificationType.chat => const Icon(Icons.chat_bubble),
      _ => const Icon(Icons.check)
    };
  }

  final String title;
  final String content;
  final Widget leading;
  final DateTime time;
  final bool isRead;
  final Widget? bottom;
  final void Function()? onPressed;

  const _NotificationCard({
    required this.title,
    required this.content,
    required this.leading,
    required this.time,
    // ignore: unused_element
    this.bottom,
    // ignore: unused_element
    this.isRead = false,
    // ignore: unused_element
    this.onPressed
  });

  _NotificationCard.fromNotification(models.Notification notification, {this.bottom, this.onPressed}) :
    title = notification.title,
    content = notification.content,
    time = notification.createdAt,
    isRead = notification.isRead,
    leading = _getLeading(notification.type);

  @override
  State<_NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<_NotificationCard> {
  bool _isRead = false;

  @override
  void initState() {
    super.initState();
    _isRead = widget.isRead;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: _isRead ? 1 : 3,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            setState(() => _isRead = true);
            widget.onPressed?.call();
          },
          child: Column(
            children: [
              const SizedBox(height: 8),
              ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: widget.leading
                ),
                title: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    widget.title,
                    style: context.textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify
                  ),
                ),
                subtitle: Text("${widget.time.toDateString()} at ${widget.time.to24HourString()}"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.content,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: _isRead ? FontWeight.normal : FontWeight.bold
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              if (widget.bottom != null) widget.bottom!,
              const SizedBox(height: 24)
            ],
          ),
        ),
      ),
    );
  }
}