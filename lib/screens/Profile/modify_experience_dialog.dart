import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/models/experience.dart';
import 'package:student_hub_flutter/screens/profile/modify_category_dialog.dart';

class ModifyExperienceDialog extends StatefulWidget {
  final String title;
  final void Function()? onDelete;
  final void Function(Experience)? onDone;
  final Experience? experience;

  const ModifyExperienceDialog({
    super.key,
    this.onDone,
    required this.title,
    this.onDelete,
    this.experience
  });

  @override
  State<ModifyExperienceDialog> createState() => _ModifyExperienceDialogState();
}

class _ModifyExperienceDialogState extends State<ModifyExperienceDialog> {
  late Experience _experience;
  late TextEditingController _nameTextController;
  late TextEditingController _descriptionTextController;

  @override
  void initState() {
    super.initState();
    _experience = widget.experience ?? Experience(startTime: DateTime.now(), endTime: DateTime.now(), skillSet: []);
    _nameTextController = TextEditingController()..text = _experience.title;
    _descriptionTextController = TextEditingController()..text = _experience.description;
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModifyCategoryDialog(
      title: widget.title,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Title", style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(controller: _nameTextController),
          const SizedBox(height: 32),
          const Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(controller: _descriptionTextController),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment:  CrossAxisAlignment.center,
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              const Text("From", style: TextStyle(fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () => _pickTime(context, (time) => _experience.startTime = time),
                child: Text(_experience.startTime.toMonthString())
              ),
              const Spacer(),
              const Text("To", style: TextStyle(fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () => _pickTime(context, (time) => _experience.endTime = time),
                child: Text(_experience.endTime.toMonthString())
              ),
            ],
          )
        ]
      ),
      onCancel: () {},
      onDelete: widget.onDelete,
      onDone: () {
        _experience.name = _nameTextController.text;
        _experience.description = _descriptionTextController.text;
        widget.onDone?.call(_experience);
      },
    );
  }

  _pickTime(BuildContext context, void Function(DateTime time) setter) async {
    var now = DateTime.now();

    var time = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 100),
      lastDate: DateTime.now()
    );

    if (time != null) {
      setState(() => setter(time));
    }
  }
}