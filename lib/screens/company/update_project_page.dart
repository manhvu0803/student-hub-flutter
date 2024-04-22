import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client/company_client.dart' as client;
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/extensions/string_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/screens/views/editable_project_view.dart';
import 'package:student_hub_flutter/widgets.dart';

class UpdateProjectPage extends StatefulWidget {
  final Project project;
  final void Function(Project project)? onProjectUpdated;

  const UpdateProjectPage(this.project, {super.key, this.onProjectUpdated});

  @override
  State<UpdateProjectPage> createState() => _UpdateProjectPageState();
}

class _UpdateProjectPageState extends State<UpdateProjectPage> {
  late Project _project;

  @override
  void initState() {
    super.initState();
    _project = widget.project.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 22.0),
        child: FloatingActionButton.extended(
          onPressed: () => _updateProject(context),
          label: const Text("Update"),
          icon: const Icon(Icons.edit),
        ),
      ),
      title: "Update ${widget.project.title}",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(height: 32),
            EditableProjectView(_project),
            const SizedBox(height: 30),

            Row(
              children: [
                const TitleText("Progress"),
                const Spacer(),
                DropdownButton(
                  value: _project.type,
                  items: ProjectType.values.mapToList((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item.name.uppercaseFirstLetter)
                  )),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _project.type = value);
                    }
                  }
                )
              ],
            ),
            const SizedBox(height: 120),
          ],
        ),
      )
    );
  }

  void _updateProject(BuildContext context) {
    context.loadWithDialog(
      client.updateProject(_project),
      onDone: (data) {
        Navigator.pop(context);
        widget.onProjectUpdated?.call(_project);
      }
    );
  }
}