import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/screens/company/company_project_page.dart';
import 'package:student_hub_flutter/screens/company/post_project_page.dart';
import 'package:student_hub_flutter/client/company_client.dart' as client;
import 'package:student_hub_flutter/widgets/project_card.dart';
import 'package:student_hub_flutter/widgets/refreshable_future_builder.dart';

class CompanyDashboard extends StatelessWidget {
  const CompanyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () => context.pushRoute((context) => const PostProjectPage()),
            child: const Text("Post a project")
          ),
        ),
        const DefaultTabController(
          length: 3,
          child: Expanded(
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: "All projects"),
                    Tab(text: "Working"),
                    Tab(text: "Done"),
                  ]
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: TabBarView(
                      children: [
                        _DashboardProjectListView(),
                        _DashboardProjectListView(),
                        _DashboardProjectListView(),
                      ]
                    ),
                  ),
                )
              ]
            ),
          ),
        )
      ],
    );
  }
}

class _DashboardProjectListView extends StatelessWidget {
  const _DashboardProjectListView();

  @override
  Widget build(BuildContext context) {
    return RefreshableFutureBuilder(
      fetcher: client.getProjects,
      builder: (context, data) => ListView(
        children: data.mapToList((project) => _DashboardProjectCard(project))
      )
    );
  }
}

class _DashboardProjectCard extends StatelessWidget {
  final Project project;

  const _DashboardProjectCard(this.project);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4.0),
      child: ProjectCard.fromProject(
        project,
        onPressed: () => context.pushRoute((context) => CompanyProjectPage(project)),
        contentBottom: _getRequestWidget(context),
        bottom: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${project.proposalCount} proposal(s)"),
              Text("${project.messageCount} message(s)"),
              Text("${project.hireCount} hired")
            ]
          ),
        ),
      )
    );
  }

  Widget? _getRequestWidget(BuildContext context) {
    if (project.proposals.isEmpty) {
      return null;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            "Student are looking for",
            style: context.textTheme.titleMedium,
          ),
          ...project.proposals.map((request) => Text(
            " - $request",
            style: context.textTheme.bodyMedium,
          ))
        ],
      ),
    );
  }
}