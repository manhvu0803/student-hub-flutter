import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/widgets.dart';

class MeetingCard extends StatelessWidget {
  final Meeting meeting;

  const MeetingCard.fromMeeting(this.meeting, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),
              TitleText(meeting.title),
              const SizedBox(height: 6),
              Opacity(
                opacity: 0.75,
                child: IconText(
                  Icons.schedule,
                  "${meeting.startTime.toDateString()}, ${meeting.startTime.to24HourString()} - ${meeting.endTime.to24HourString()}",
                  textStyle: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              if (meeting.content.isNotEmpty) const SizedBox(height: 8),
              if (meeting.content.isNotEmpty) Text(
                meeting.content,
                style: context.textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              if (meeting.room != null) _getRoomWidgets(context, meeting.room!),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getRoomWidgets(BuildContext context, MeetingRoom room) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Meeting room",
            style: context.textTheme.titleMedium,
          ),
          Text("Room ID: ${room.userDefinedId}"),
          Text("Room code: ${room.code}"),
        ],
      ),
    );
  }
}