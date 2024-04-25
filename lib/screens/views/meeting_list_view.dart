import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/widgets.dart';
import 'package:student_hub_flutter/client.dart' as client;

class MeetingListView extends StatelessWidget {
  const MeetingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshableFutureBuilder.forCollection(
      fetcher: () => client.getMeetings(),
      builder: (context, data) => ListView(
        children: data.mapToList((meeting) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: MeetingCard.fromMeeting(meeting),
        ))
      ),
    );
  }
}