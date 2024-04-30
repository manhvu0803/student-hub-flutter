import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_hub_flutter/client/student_client.dart' as client;
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/widgets/refreshable_future_builder.dart';

import 'student_project_card.dart';

class ProjectSearchListView extends StatefulWidget {
  final void Function()? onPop;

  const ProjectSearchListView({super.key, this.onPop});

  @override
  State<ProjectSearchListView> createState() => _ProjectSearchListViewState();
}

class _ProjectSearchListViewState extends State<ProjectSearchListView> {
  String? _titleQuery;
  int _page = 1;
  int? _numberOfStudents;
  ProjectScope? _selectedScope;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: SearchBar(
                    hintText: "Search projects...",
                    hintStyle: const MaterialStatePropertyAll(TextStyle(fontStyle: FontStyle.italic)),
                    onSubmitted: (value) => setState(() => _titleQuery = value),
                    leading: const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 2),
                      child: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                MenuAnchor(
                  menuChildren: _getFilterMenuChildren(),
                  builder: (context, controller, child) => TextButton(
                    onPressed: () => controller.isOpen ? controller.close() : controller.open(),
                    child: const Text("Filters")
                  ),
                )
              ],
            )
          ),
          const SizedBox(height: 12),

          Expanded(
            child: RefreshableFutureBuilder.forCollection(
              emptyString: "No projects found",
              fetcher: () => client.searchProject(
                projectTitle: _titleQuery,
                page: _page,
                scope: _selectedScope,
                numberOfStudents: _numberOfStudents
              ),
              builder: (context, data) => ListView(
                children: data.mapToList((project) => StudentProjectCard(project, onPop: widget.onPop)),
              )
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: (_page > 1) ? () => setState(() => _page--) : null,
                icon: const Icon(Icons.arrow_back)
              ),
              Text(
                "Page $_page",
                style: context.textTheme.titleMedium,
              ),
              IconButton(
                onPressed: () => setState(() => _page++),
                icon: const Icon(Icons.arrow_forward)
              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _getFilterMenuChildren() {
    return [
      const ListTile(title: Text(
        "Scope",
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      ...ProjectScope.values.map((scope) => ListTile(
        leading: Radio(
          value: scope,
          groupValue: _selectedScope,
          onChanged: (value) => setState(() => _selectedScope = value)
        ),
        title: Text(scope.description),
      )),
      ListTile(
        title: const SizedBox(
          width: 185,
          child: Text(
            "Number of students",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ),
        trailing: SizedBox(
          width: 60,
          child: TextField(
            textAlign: TextAlign.center,
            controller: TextEditingController()..text = _numberOfStudents?.toString() ?? "",
            keyboardType: TextInputType.number,
            onChanged: (value) => _numberOfStudents = int.tryParse(value),
            onEditingComplete: () {
              if ((_numberOfStudents ?? -1) > 0) {
                setState(() {});
              }
            }
          ),
        ),
      )
    ];
  }
}