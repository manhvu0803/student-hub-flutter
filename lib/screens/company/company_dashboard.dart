import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/screens/company/post_project_page.dart';
import 'package:student_hub_flutter/widgets/project_list_view.dart';

import 'company_project_card.dart';

class CompanyDashboard extends StatefulWidget {
  const CompanyDashboard({super.key});

  @override
  State<CompanyDashboard> createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends State<CompanyDashboard> {
  @override
  Widget build(BuildContext context) {
    Widget projectCardBuilder(Project project) {
      return CompanyProjectCard(
        project,
        onPop: () {
          if (context.mounted) {
            setState(() {});
          }
        },
      );
    }

    return Stack(
      children: [
        DefaultTabController(
          initialIndex: 1,
          length: 3,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: "All projects"),
                  Tab(text: "Working"),
                  Tab(text: "Done"),
                ]
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TabBarView(
                    children: [
                      ProjectListView.company(childBuilder: projectCardBuilder),
                      ProjectListView.company(
                        childBuilder: projectCardBuilder,
                        projectFilter: (project) => project.status == ProjectStatus.working
                      ),
                      ProjectListView.company(
                        childBuilder: projectCardBuilder,
                        projectFilter: (project) => project.status != ProjectStatus.working
                      ),
                    ]
                  ),
                ),
              )
            ]
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