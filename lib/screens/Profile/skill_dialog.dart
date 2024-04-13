import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client/student_client.dart' as client;
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/category.dart';
import 'package:student_hub_flutter/widgets/skill_button.dart';

class SkillDialog extends StatefulWidget {
  final List<Category> chosenSkills;
  final void Function(List<Category>)? onDoneChoosing;

  const SkillDialog({super.key, required this.chosenSkills, this.onDoneChoosing});

  @override
  State<SkillDialog> createState() => _SkillDialogState();
}

class _SkillDialogState extends State<SkillDialog> {
  late final List<Category> _chosenSkills;

  @override
  void initState() {
    super.initState();
    _chosenSkills = widget.chosenSkills;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text("Skills", style: TextStyle(fontWeight: FontWeight.bold)),
      content: Wrap(
        children: client.skillSets.values.mapToList(_buildDialogSkillButton)
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel")
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onDoneChoosing?.call(_chosenSkills);
          },
          child: const Text("Done")
        )
      ],
    );
  }

  Widget _buildDialogSkillButton(Category skill) {
    var isEnabled = _chosenSkills.contains(skill);
    var stateCallback = isEnabled ? () => _chosenSkills.remove(skill) : () => _chosenSkills.add(skill);

    return SkillButton(
      skill.name,
      onPressed: () => setState(stateCallback),
      isEnabled: isEnabled
    );
  }
}
