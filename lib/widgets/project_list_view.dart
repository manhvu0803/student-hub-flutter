import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client/company_client.dart' as company_client;
import 'package:student_hub_flutter/client/student_client.dart' as student_client;
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/widgets/refreshable_future_builder.dart';

class ProjectListView extends StatelessWidget {
  final Future<Iterable<Project>> Function() projectFetcher;
  final Widget Function(Project project) childBuilder;

  const ProjectListView({
    super.key,
    required this.childBuilder,
    required this.projectFetcher,
  });

  ProjectListView.company({
    super.key,
    bool Function(Project project)? projectFilter,
    required this.childBuilder,
  }) :
    projectFetcher = (() async {
      var projects = await company_client.getProjects();
      return (projectFilter == null) ? projects : projects.where(projectFilter);
    });

  ProjectListView.student({
    super.key,
    bool Function(Project project)? projectFilter,
    required ProjectType projectType,
    required this.childBuilder,
  }) :
    projectFetcher = (() async {
      var projects = await student_client.getProjects(projectType: projectType);
      return (projectFilter == null) ? projects : projects.where(projectFilter);
    });

  @override
  Widget build(BuildContext context) {
    return RefreshableFutureBuilder.forCollection(
      emptyString: "No project found",
      fetcher: projectFetcher,
      builder: (context, data) => ListView(
        children: [
          const SizedBox(height: 12),
          ...data.map(childBuilder)
        ]
      )
    );
  }
}