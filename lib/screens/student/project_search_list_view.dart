import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client/student_client.dart' as client;
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
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
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: SearchBar(
              hintText: "Search projects...",
              hintStyle: const MaterialStatePropertyAll(TextStyle(fontStyle: FontStyle.italic)),
              onChanged: (value) => _titleQuery = value,
              onSubmitted: (value) => setState(() => _titleQuery = value),
              leading: const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 2),
                child: Icon(Icons.search),
              ),
            )
          ),
          const SizedBox(height: 12),
          Expanded(
            child: RefreshableFutureBuilder.forCollection(
              emptyString: "No projects found",
              fetcher: () => client.searchProject(
                projectTitle: _titleQuery,
                page: page
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
                onPressed: (page > 1) ? () => setState(() => page--) : null,
                icon: const Icon(Icons.arrow_back)
              ),
              Text(
                "Page $page",
                style: context.textTheme.titleMedium,
              ),
              IconButton(
                onPressed: () => setState(() => page++),
                icon: const Icon(Icons.arrow_forward)
              )
            ],
          )
        ],
      ),
    );
  }
}