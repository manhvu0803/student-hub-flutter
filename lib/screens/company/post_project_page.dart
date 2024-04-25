import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/widgets.dart';
import 'package:student_hub_flutter/client/company_client.dart' as client;

import '../views/editable_project_view.dart';

class PostProjectPage extends StatelessWidget {
  final Project _project = Project();

  PostProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.875,
          child: ListView(
            children: [
              const SizedBox(height: 30),
              Text(
                "Create a new project",
                style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 30),
              EditableProjectView(_project),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _onPostProjet(context),
                  child: const Text("Post project")
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        )
      )
    );
  }

  void _onPostProjet(BuildContext context) {
    if ((_project.numberOfStudents) <= 0) {
      context.showTextSnackBar("Please specify the number of student needed");
      return;
    }

    context.showRequestLoad(
      request: () => client.createProject(_project),
      onRequestDone: () => Navigator.pop(context),
    );
  }
}