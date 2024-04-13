import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/screens/post_project_page.dart';
import 'package:student_hub_flutter/screens/company/project_page.dart';

class CompanyDashboard extends StatelessWidget {
  const CompanyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () => context.pushRoute((context) => const PostProjectTitle()),
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
                  child: TabBarView(
                    children: [
                      _DashboardProjectListView(),
                      _DashboardProjectListView(),
                      _DashboardProjectListView(),
                    ]
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
    return ListView(
      children: [
        _DashboardProjectCard(
          title: "Senior frontend developer (Fintech)",
          createTime: DateTime.now().subtract(const Duration(days: 3)),
          requests: const [
            "Clear expectation about your project or deliverables",
            "Detail tasks"
          ],
          proposalCount: 2,
          messageCount: 4,
          hireCount: 1
        )
      ]
    );
  }
}

class _DashboardProjectCard extends StatelessWidget {
  final String title;

  final DateTime createTime;

  final List<String> requests;

  final int proposalCount;

  final int messageCount;

  final int hireCount;

  const _DashboardProjectCard({
    required this.title,
    required this.createTime,
    required this.requests,
    required this.proposalCount,
    required this.messageCount,
    required this.hireCount
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => context.pushRoute((context) => const ProjectPage(projectName: "projectName")),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium,
                  ),
                  Text(
                    "Created ${createTime.toDateString()}",
                    style: TextStyle(color: context.textTheme.titleMedium!.color!.withAlpha(255 ~/ 1.5)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Student are looking for",
                    style: context.textTheme.titleMedium,
                  ),
                  ..._getRequestTexts(context),
                ]
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("$proposalCount proposal(s)"),
                Text("$messageCount message(s)"),
                Text("$hireCount hired")
              ]
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Iterable<Widget> _getRequestTexts(BuildContext context) {
    return requests.map((request) => Text(
      " - $request",
      style: context.textTheme.bodyMedium,
    ));
  }
}