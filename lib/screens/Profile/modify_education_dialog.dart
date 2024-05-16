import 'package:flutter/material.dart';
import 'package:student_hub_flutter/models/education.dart';
import 'package:student_hub_flutter/screens/profile/modify_category_dialog.dart';

class ModifyEducationDialog extends StatefulWidget {
  final String title;
  final void Function()? onDelete;
  final void Function(Education)? onDone;
  final Education? education;

  const ModifyEducationDialog({
    super.key,
    this.onDone,
    required this.title,
    this.onDelete,
    this.education
  });

  @override
  State<ModifyEducationDialog> createState() => _ModifyEducationDialogState();
}

class _ModifyEducationDialogState extends State<ModifyEducationDialog> {
  late Education _education;
  late TextEditingController _nameTextController;
  late TextEditingController _startYearTextController;
  late TextEditingController _endYearTextController;

  @override
  void initState() {
    super.initState();
    _education = widget.education ?? Education();
    _nameTextController = TextEditingController()..text = _education.schoolName;
    _startYearTextController = TextEditingController()..text = (_education.startYear > 0) ? _education.startYear.toString() : "";
    _endYearTextController = TextEditingController()..text = (_education.endYear > 0) ? _education.endYear.toString() : "";
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _startYearTextController.dispose();
    _endYearTextController.dispose();
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
          const Text("School name", style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(controller: _nameTextController),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment:  CrossAxisAlignment.center,
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              const Text("From", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              SizedBox(
                width: 50,
                child: TextField(controller: _startYearTextController)
              ),
              const Spacer(),
              const Text("To", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              SizedBox(
                width: 50,
                child: TextField(controller: _endYearTextController)
              ),
            ],
          )
        ]
      ),
      onCancel: () {},
      onDelete: widget.onDelete,
      onDone: () {
        var thisYear = DateTime.now().year;
        _education.name = _nameTextController.text;
        _education.startYear = int.tryParse(_startYearTextController.text) ?? thisYear;
        _education.endYear = int.tryParse(_endYearTextController.text) ?? thisYear;
        widget.onDone?.call(_education);
      },
    );
  }
}