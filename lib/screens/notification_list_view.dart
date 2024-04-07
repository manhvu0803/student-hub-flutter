import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';

class NotificationListView extends StatelessWidget {
  const NotificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _NotificationCard(
          title: "You have submitted to join project \"Javis - AI Copilot\"",
          leading: Image.network("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
          time: DateTime(2024, 6, 6)
        ),
        _NotificationCard(
          title: "You have invited to interview for project \"Javis - AI Copilot\" at 14:00 March 20, Thursday",
          leading: const Icon(Icons.settings),
          time: DateTime(2024, 12, 2),
          bottom: ElevatedButton(
            onPressed: () {},
            child: const Text("Join"),
          ),
        ),
        _NotificationCard(
          title: "You have offder to join project \"Javis - AI Copilot\"",
          leading: const Icon(Icons.settings),
          time: DateTime(2024, 12, 2),
          bottom: const ElevatedButton(
            onPressed: null,
            child: Text("View offer"),
          ),
        )
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String title;

  final Widget leading;

  final DateTime time;

  final Widget? bottom;

  const _NotificationCard({
    required this.title,
    required this.leading,
    required this.time,
    this.bottom
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            const SizedBox(height: 8),
            ListTile(
              titleAlignment: ListTileTitleAlignment.titleHeight,
              leading: SizedBox(
                width: 24,
                height: 24,
                child: leading
              ),
              title: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  title,
                  style: context.textTheme.titleSmall,
                  textAlign: TextAlign.justify
                ),
              ),
              subtitle: Text(time.toDateString()),
            ),
            if (bottom != null) bottom!,
            const SizedBox(height: 12)
          ],
        ),
      ),
    );
  }
}