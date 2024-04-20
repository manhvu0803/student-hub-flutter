import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client/chat_client.dart' as client;
import 'package:student_hub_flutter/client/company_client.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/models/message.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/screens/views/chat_list_view.dart';
import 'package:student_hub_flutter/screens/views/project_detail_view.dart';
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
                onPressed: () => _deleteProject(context),
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
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
              child: ProjectDetailView(project),
            ),
            ChatListView(
              hasSearchBar: false,
              chatGetter: _getChats
            ),
            ProjectHiredView(project),
          ],
        ),
      ),
    );
  }

  Future<List<Message>> _getChats() async {
    var chats = await client.getAllChat(projectId: project.id);

    for (var chat in chats) {
      chat.project = project;
    }

    return chats;
  }

  void _deleteProject(BuildContext context) {
    context.loadWithDialog(
      deleteProject(project.id),
      onDone: (data) => Navigator.pop(context)
    );
  }
}