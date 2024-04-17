import 'package:flutter/material.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/screens/views/chat_list_view.dart';
import 'package:student_hub_flutter/screens/company/project_detail_view.dart';
import 'package:student_hub_flutter/screens/company/project_hired_view.dart';
import 'package:student_hub_flutter/screens/company/project_proposal_view.dart';
import 'package:student_hub_flutter/widgets.dart';

class CompanyProjectPage extends StatelessWidget {
  final Project project;

  const CompanyProjectPage(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: PageScreen(
        title: project.title,
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
          MenuAnchor(
            menuChildren: [
              MenuItemButton(
                onPressed: () {},
                child: const IconText(Icons.delete, "Delete project")
              ),
              MenuItemButton(
                onPressed: () {},
                child: const IconText(Icons.edit, "Update project")
              ),
            ],
            builder: (context, controller, child) => IconButton(
              onPressed: () => controller.isOpen ? controller.close() : controller.open(),
              icon: const Icon(Icons.more_vert)
            ),
          )
        ],
        child: TabBarView(
          children: [
            ProjectProposalView(project),
            ProjectDetailView(project),
            ChatListView(),
            ProjectHiredView(),
          ],
        ),
      ),
    );
  }
}