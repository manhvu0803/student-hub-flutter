import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/screens/company/project_detail_view.dart';
import 'package:student_hub_flutter/screens/company/project_hired_view.dart';
import 'package:student_hub_flutter/screens/company/project_proposal_view.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';

class ProjectPage extends StatelessWidget {
  final String projectName;

  const ProjectPage({
    super.key,
    required this.projectName
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: PageScreen(
        title: projectName,
        floatingActionButton: FloatingActionButton(onPressed: () => context.showScheduleInterviewDialog()),
        appBarBottom: const TabBar(
          labelPadding: EdgeInsets.symmetric(horizontal: 0),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(text: "Proposals"),
            Tab(text: "Details"),
            Tab(text: "Message"),
            Tab(text: "Hired"),
          ]
        ),
        child: const TabBarView(
          children: [
            ProjectProposalView(),
            ProjectDetailView(),
            Column(),
            ProjectHiredView(),
          ],
        )
      ),
    );
  }
}