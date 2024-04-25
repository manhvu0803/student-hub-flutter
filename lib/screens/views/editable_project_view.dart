import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/widgets.dart';

class EditableProjectView extends StatefulWidget {
  final Project project;
  final void Function(Project project)? onChanged;

  const EditableProjectView(this.project, {super.key, this.onChanged});

  @override
  State<EditableProjectView> createState() => _EditableProjectViewState();
}


class _EditableProjectViewState extends State<EditableProjectView> {
  late Project _project;

  @override
  void initState() {
    super.initState();
    _project = widget.project;
  }

  @override
  void didUpdateWidget(covariant EditableProjectView oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.onChanged?.call(_project);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText("Title"),
        TextField(
          onChanged: (value) => _project.title = value,
          decoration: const InputDecoration(
            hintText: "Name your project"
          ),
          controller: TextEditingController()..text = _project.title
        ),
        const SizedBox(height: 30),

        Row(
          children: [
            const TitleText("Duration"),
            const Spacer(),
            DropdownButton(
              value: _project.scope,
              items: ProjectScope.values.mapToList((item) => DropdownMenuItem(
                value: item,
                child: Text(item.description)
              )),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _project.scope = value);
                }
              }
            )
          ],
        ),
        const SizedBox(height: 30),

        const TitleText("Number of people"),
        TextField(
          onChanged: (value) => _project.numberOfStudents = int.tryParse(value) ?? -1,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            hintText: "The number of students your project need"
          ),
          controller: (_project.numberOfStudents >= 0) ? (TextEditingController()..text = _project.numberOfStudents.toString()) : null
        ),
        const SizedBox(height: 30),

        const TitleText("Description"),
        TextField(
          onChanged: (value) => _project.description = value,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: "Describe your project"
          ),
          controller: TextEditingController()..text = _project.description
        ),
      ],
    );
  }

  // Old radio selection
  // List<Widget> _getDurationWidgets() {
  //   return ProjectScope.values.mapToList((scope) => ListTile(
  //     leading: Radio(
  //       value: scope,
  //       groupValue: _project.scope,
  //       onChanged: (value) => setState(() => _project.scope = value ?? ProjectScope.short),
  //     ),
  //     title: Text(
  //       scope.description,
  //       style: Theme.of(context).textTheme.bodyLarge
  //     )
  //   ));
  // }
}