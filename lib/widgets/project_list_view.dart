import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client/company_client.dart' as client;
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/widgets/refreshable_future_builder.dart';

class ProjectListView extends StatelessWidget {
  final bool Function(Project project)? projectFilter;
  final Widget Function(Project project) childBuilder;

  const ProjectListView({
    super.key,
    required this.childBuilder,
    this.projectFilter
  });

  @override
  Widget build(BuildContext context) {
    return RefreshableFutureBuilder(
      fetcher: () async {
        var projects = await client.getProjects();
        return (projectFilter == null) ? projects : projects.where(projectFilter!);
      },
      builder: (context, data) => ListView(
        children: data.mapToList(childBuilder)
      )
    );
  }
}