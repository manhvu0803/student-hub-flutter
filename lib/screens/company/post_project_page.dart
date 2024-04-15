import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';
import 'package:student_hub_flutter/client/company_client.dart' as client;

class PostProjectPage extends StatefulWidget {
  final Project? project;

  const PostProjectPage({super.key, this.project});

  @override
  State<PostProjectPage> createState() => _PostProjectTitle();
}

class _PostProjectTitle extends State<PostProjectPage> {
  late final Project _project;

  @override
  void initState() {
    super.initState();
    _project = widget.project ?? Project();
  }

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
              const _TitleText("Title"),
              TextField(
                onChanged: (value) => _project.title = value,
                decoration: const InputDecoration(
                  hintText: "Name your project"
                ),
              ),
              const SizedBox(height: 30),
              const _TitleText("Duration"),
              ..._getDurationWidgets(),
              const SizedBox(height: 30),
              const _TitleText("Number of people"),
              TextField(
                onChanged: (value) => _project.numberOfStudent = int.tryParse(value) ?? -1,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  hintText: "The number of students your project need"
                ),
              ),
              const SizedBox(height: 30),
              const _TitleText("Description"),
              TextField(
                onChanged: (value) => _project.description = value,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Describe your project"
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _onPostProjet(context),
                  child: const Text("Post project")
                ),
              )
            ],
          ),
        )
      )
    );
  }

  List<Widget> _getDurationWidgets() {
    var widgets = <Widget>[];

    for (var scope in ProjectScope.values) {
      widgets.add(ListTile(
        leading: Radio(
          value: scope,
          groupValue: _project.scope,
          onChanged: (value) => setState(() => _project.scope = value ?? ProjectScope.short),
        ),
        title: Text(
          scope.description,
          style: Theme.of(context).textTheme.bodyLarge
        )
      ));
    }

    return widgets;
  }

  void _onPostProjet(BuildContext context) {
    if (_project.numberOfStudent <= 0) {
      context.showTextSnackBar("Please specify the number of student needed");
      return;
    }

    context.showRequestLoad(
      request: () => client.createProject(_project),
      onRequestDone: () => Navigator.pop(context),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String text;

  const _TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.titleMedium,
    );
  }
}