import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/string_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/widgets/project_list_view.dart';
import 'package:student_hub_flutter/client/student_client.dart' as client;
import 'student_project_card.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  Widget build(BuildContext context) {
    Widget projectCardBuilder(Project project) {
      return StudentProjectCard(
        project,
        onPop: () {
          if (context.mounted) {
            setState(() {});
          }
        },
      );
    }

    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Column(
        children: [
          TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            isScrollable: true,
            tabs: [
              const Tab(text: "Favorites"),
              ...ProjectType.values.map((type) => Tab(
                text: type.name.uppercaseFirstLetter
              )),
            ]
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TabBarView(
                children: [
                  ProjectListView(
                    projectFetcher: () => client.getFavoriteProjects(),
                    childBuilder: projectCardBuilder
                  ),
                  ProjectListView.student(
                    projectType: ProjectType.preparing,
                    childBuilder: projectCardBuilder
                  ),
                  ProjectListView.student(
                    projectType: ProjectType.working,
                    childBuilder: projectCardBuilder,
                  ),
                  ProjectListView.student(
                    projectType: ProjectType.archived,
                    childBuilder: projectCardBuilder,
                  ),
                ]
              ),
            ),
          )
        ]
      ),
    );
  }
}