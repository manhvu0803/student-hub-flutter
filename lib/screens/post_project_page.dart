import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';
import 'package:student_hub_flutter/client/client.dart' as client;

class PostProjectTitle extends StatefulWidget {
  final Project? project;

  const PostProjectTitle({super.key, this.project});

  @override
  State<PostProjectTitle> createState() => _PostProjectTitle();
}

class _PostProjectTitle extends State<PostProjectTitle> {
  static const List<String> durationStrings = [
    "1 - 3 months",
    "3 - 6 months",
    "6 - 12 months",
  ];

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
          heightFactor: 0.9,
          child: ListView(
            children: [
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

    for (int i = 0; i < durationStrings.length; ++i) {
      widgets.add(ListTile(
        leading: Radio(
          value: i,
          groupValue: _project.projectScope,
          onChanged: (value) => setState(() => _project.projectScope = value ?? -1),
        ),
        title: Text(
          durationStrings[i],
          style: Theme.of(context).textTheme.bodyLarge
        )
      ));
    }

    return widgets;
  }

  void _onPostProjet(BuildContext context) {
    if (_project.projectScope < 0) {
      context.showTextSnackBar("Please choose a duration");
      return;
    }

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