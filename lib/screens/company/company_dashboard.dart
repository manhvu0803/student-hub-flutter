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
    return Stack(
      children: [
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
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: FloatingActionButton.extended(
              onPressed: () => context.pushRoute((context) => PostProjectPage()),
              label: const Text("New project"),
              icon: const Icon(Icons.add),
            ),
          ),
        )
      ],
    );
  }
}

class _DashboardProjectListView extends StatefulWidget {
  const _DashboardProjectListView();

  @override
  State<_DashboardProjectListView> createState() => _DashboardProjectListViewState();
}

class _DashboardProjectListViewState extends State<_DashboardProjectListView> {
  @override
  Widget build(BuildContext context) {
    return RefreshableFutureBuilder(
      fetcher: client.getProjects,
      builder: (context, data) => ListView(
        children: data.mapToList((project) => _DashboardProjectCard(
          project,
          onPop: () {
            if (context.mounted) {
              setState(() {});
            }
          }
        ))
      )
    );
  }
}

class _DashboardProjectCard extends StatelessWidget {
  static const int _extraInfoLimit = 2;
  final Project project;
  final void Function()? onPop;

  const _DashboardProjectCard(this.project, {this.onPop});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4.0),
      child: ProjectCard.fromProject(
        project,
        onPressed: () => context.pushRoute(
          (context) => CompanyProjectPage(project),
          onPop: onPop
        ),
        contentBottom: _getRequestWidget(context),
        bottom: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${project.proposalCount} proposal${(project.proposalCount > 1) ? "s" : ""}"),
              Text("${project.messageCount} message${(project.messageCount > 1) ? "s" : ""}"),
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
            "Student that is applying",
            style: context.textTheme.titleMedium,
          ),
          ..._getApplyingStudents(context)
        ],
      ),
    );
  }

  Iterable<Widget> _getApplyingStudents(BuildContext context) {
    var widgets = <Widget>[];
    var proposals = project.proposals;

    for (int i = 0; i < proposals.length && i < _extraInfoLimit; i++) {
      widgets.add(Text(
        " - ${proposals[i].student!.name}",
        style: context.textTheme.bodyMedium,
      ));
    }

    if (proposals.length > _extraInfoLimit) {
      widgets.add(Text(
        " - ...",
        style: context.textTheme.bodyMedium,
      ));
    }

    return widgets;
  }
}