import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client/student_client.dart' as client;
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/screens/student/student_project_page.dart';
import 'package:student_hub_flutter/widgets/project_card.dart';
import 'package:student_hub_flutter/widgets/refreshable_future_builder.dart';

class ProjectListView extends StatefulWidget {
  const ProjectListView({super.key});

  @override
  State<ProjectListView> createState() => _ProjectListViewState();
}

class _ProjectListViewState extends State<ProjectListView> {
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
            child: RefreshableFutureBuilder(
              fetcher: () => client.searchProject(
                projectTitle: _titleQuery,
                page: page
              ),
              builder: (context, data) {
                return ListView(
                  children: data.mapToList((project) => _ListViewProjectCard(project)),
                );
              }
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

class _ListViewProjectCard extends StatefulWidget {
  final Project project;

  const _ListViewProjectCard(this.project);

  @override
  State<_ListViewProjectCard> createState() => _ListViewProjectCardState();
}

class _ListViewProjectCardState extends State<_ListViewProjectCard> {
  late Project _project;

  @override
  void initState() {
    super.initState();
    _project = widget.project;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ProjectCard.fromProject(
        widget.project,
        onPressed: () => context.pushRoute((context) => StudentProjectPage(_project)),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () => _onToggleFavorite(context),
            icon: Icon(
              widget.project.isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: Colors.red
            ),
          ),
        ),
      ),
    );
  }

  void _onToggleFavorite(BuildContext context) async {
    try {
      await client.setFavorite(_project, !_project.isFavorite);
      setState(() => _project.isFavorite = !_project.isFavorite);
    }
    catch (e) {
      if (context.mounted) {
        context.showTextSnackBar(e.toString());
      }
    }
  }
}