import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/screens/views/chat_list_view.dart';
import 'package:student_hub_flutter/screens/company/project_detail_view.dart';
import 'package:student_hub_flutter/screens/company/project_hired_view.dart';
import 'package:student_hub_flutter/screens/company/project_proposal_view.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';

class CompanyProjectPage extends StatelessWidget {
  final Project project;

  const CompanyProjectPage(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: PageScreen(
        title: project.title,
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
        actions: [
          MenuBar(children: [
            SubmenuButton(
              menuChildren: [
                MenuItemButton(
                  onPressed: () {},
                  child: const Text("Delete project")
                ),
                MenuItemButton(
                  onPressed: () {},
                  child: const Text("Update info")
                )
              ],
              child: const Icon(Icons.more_vert),
            ),
          ])
        ],
        child: const TabBarView(
          children: [
            ProjectProposalView(),
            ProjectDetailView(),
            ChatListView(),
            ProjectHiredView(),
          ],
        ),
      ),
    );
  }
}