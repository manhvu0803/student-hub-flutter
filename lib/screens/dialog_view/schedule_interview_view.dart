import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/extensions/time_of_day_extension.dart';

class ScheduleInterviewView extends StatefulWidget {
  const ScheduleInterviewView({super.key});

  @override
  State<ScheduleInterviewView> createState() => _ScheduleInterviewViewState();
}

class _ScheduleInterviewViewState extends State<ScheduleInterviewView> {
  DateTime? _startTime;

  DateTime? _endTime;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.textTheme.titleMedium!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Title"),
          const TextField(decoration: InputDecoration(hintText: "Meeting title")),
          const SizedBox(height: 32),
          const Text("Start time"),
          _TimePickerRow(
            time: _startTime,
            onSelectTime: (selectedTime) => setState(() => _startTime = selectedTime)
          ),
          const SizedBox(height: 16),
          const Text("End time"),
          _TimePickerRow(
            time: _endTime,
            onSelectTime: (selectedTime) => setState(() => _endTime = selectedTime)
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Text(
              (_startTime == null || _endTime == null) ? "" : "Duration: ${_startTime!.difference(_endTime!).inMinutes} minutes",
              style: context.textTheme.bodyLarge!.copyWith(fontStyle: FontStyle.italic)
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")
              ),
              ElevatedButton(
                onPressed: (_startTime == null || _endTime == null) ? null : () => _sendInvite(context),
                child: const Text("Send invite")
              ),
            ],
          )
        ],
      ),
    );
  }

  void _sendInvite(BuildContext context) {
    Navigator.pop(context);
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
  void didUpdateWidget(covariant _TimePickerRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    _date = widget.time;

    if (widget.time != null) {
      _timeOfDay = TimeOfDay.fromDateTime(widget.time!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20)
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
            child: Text((_timeOfDay == null) ? "__:__": _timeOfDay!.to12HString())
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

    if (selectedDate != null && _timeOfDay != null) {
      var time = selectedDate.copyWith(hour: _timeOfDay!.hour, minute: _timeOfDay!.minute);
      widget.onSelectTime?.call(time);
      return;
    }

    setState(() => _date = selectedDate);
  }

  Future<void> _pickTime(BuildContext context) async {
    var selectedTime = await showTimePicker(
      context: context,
      initialTime: (_timeOfDay != null) ? _timeOfDay! : TimeOfDay.now(),
    );

    if (selectedTime != null && _date != null) {
      var time = _date!.copyWith(hour: selectedTime.hour, minute: selectedTime.minute);
      widget.onSelectTime?.call(time);
      return;
    }

    setState(() => _timeOfDay = selectedTime);
  }
}