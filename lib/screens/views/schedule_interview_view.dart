import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client/company_client.dart' as client;
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/extensions/time_of_day_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/widgets/horizontal_title_text_field.dart';

class ScheduleInterviewView extends StatefulWidget {
  final int projectId;
  final int receiverId;

  const ScheduleInterviewView({super.key, required this.projectId, required this.receiverId});

  @override
  State<ScheduleInterviewView> createState() => _ScheduleInterviewViewState();
}

class _ScheduleInterviewViewState extends State<ScheduleInterviewView> {
  final Meeting meeting = Meeting(
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 1))
  )..room = MeetingRoom();

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.textTheme.titleMedium!,
      child: SizedBox(
        width: 600,
        height: 580,
        child: ListView(
          children: [
            const SizedBox(height: 16),
            const Text("Meeting title"),
            TextField(
              decoration: const InputDecoration(
                hintText: "Interview for project...",
                hintStyle: TextStyle(fontStyle: FontStyle.italic)
              ),
              onChanged: (value) => meeting.title = value
            ),
            const SizedBox(height: 24),

            const Text("Meeting content"),
            TextField(
              decoration: const InputDecoration(
                hintText: "Detail of the meeting...",
                hintStyle: TextStyle(fontStyle: FontStyle.italic)
              ),
              maxLines: null,
              onChanged: (value) => meeting.content = value
            ),
            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Start time"),
                  _TimePickerRow(
                    time: meeting.startTime,
                    onSelectTime: _setStartTime
                  ),
                  const SizedBox(height: 16),

                  const Text("End time"),
                  _TimePickerRow(
                    time: meeting.endTime,
                    onSelectTime: _setEndTime
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8),
                    child: Text(
                      "Duration: ${meeting.endTime.difference(meeting.startTime).inMinutes} minutes",
                      style: context.textTheme.bodyLarge!.copyWith(fontStyle: FontStyle.italic)
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),

            HorizontalTitleTextField(
              title: "Room ID:",
              distance: 29,
              onChanged: (value) => meeting.room!.userDefinedId = value
            ),

            HorizontalTitleTextField(
              title: "Room code:",
              distance: 9,
              onChanged: (value) => meeting.room!.code = value,
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel")
                ),
                ElevatedButton(
                  onPressed: () => _sendInvite(context),
                  child: const Text("Send invite")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _setEndTime(DateTime? selectedTime) {
    if (selectedTime == null) {
      return;
    }

    setState(() {
      meeting.endTime = selectedTime;

      if (meeting.endTime.difference(meeting.startTime) < const Duration(minutes: 5)) {
        meeting.startTime = meeting.endTime.subtract(const Duration(minutes: 5));
      }
    });
  }

  void _setStartTime(DateTime? selectedTime) {
    if (selectedTime == null) {
      return;
    }

    setState(() {
      var now = DateTime.now();

      if (now.compareTo(selectedTime!) > 0) {
        selectedTime = DateTime.now();
      }

      meeting.startTime = selectedTime!;

      if (meeting.endTime.difference(meeting.startTime) < const Duration(minutes: 5)) {
        meeting.endTime = selectedTime!.add(const Duration(minutes: 5));
      }
    });
  }

  Future<void> _sendInvite(BuildContext context) async {
    context.showLoadingDialog();

    try {
      await client.scheduleMeeting(
        meeting,
        projectId: widget.projectId,
        receiverId: widget.receiverId
      );
    }
    catch (e) {
      if (context.mounted) {
        context.showTextSnackBar(e.toString());
      }
    }

    if (context.mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}

class _TimePickerRow extends StatefulWidget {
  final Function(DateTime?)? onSelectTime;

  final DateTime? time;

  const _TimePickerRow({
    this.onSelectTime,
    this.time,
  });

  @override
  State<_TimePickerRow> createState() => _TimePickerRowState();
}

class _TimePickerRowState extends State<_TimePickerRow> {
  DateTime? _date;

  TimeOfDay? _timeOfDay;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _date = widget.time;

    if (widget.time != null) {
      _timeOfDay = TimeOfDay.fromDateTime(widget.time!);
    }
    return Theme(
      data: Theme.of(context).copyWith(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: context.textTheme.bodyMedium?.fontSize ?? 16)
          )
        )
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () => _pickDate(context),
            child: Text((_date == null) ? "__/__/____" : _date!.toDateString())
          ),
          const Icon(Icons.calendar_month),
          TextButton(
            onPressed: () => _pickTime(context),
            child: Text((_timeOfDay == null) ? "__:__": _timeOfDay!.to12HourString())
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    var currentDate = (_date != null) ? _date! : DateTime.now();

    var selectedDate = await showDatePicker(
      context: context,
      firstDate: currentDate,
      lastDate: currentDate.add(const Duration(days: 30))
    );

    setState(() => _date = selectedDate);

    if (selectedDate != null && _timeOfDay != null) {
      var time = selectedDate.copyWith(hour: _timeOfDay!.hour, minute: _timeOfDay!.minute);
      widget.onSelectTime?.call(time);
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    var selectedTime = await showTimePicker(
      context: context,
      initialTime: (_timeOfDay != null) ? _timeOfDay! : TimeOfDay.now(),
    );

    setState(() => _timeOfDay = selectedTime);

    if (selectedTime != null && _date != null) {
      var time = _date!.copyWith(hour: selectedTime.hour, minute: selectedTime.minute);
      widget.onSelectTime?.call(time);
    }
  }
}