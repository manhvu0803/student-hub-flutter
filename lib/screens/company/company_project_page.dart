import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client/chat_client.dart' as client;
import 'package:student_hub_flutter/client/company_client.dart' as client;
import 'package:student_hub_flutter/client/company_client.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/models/message.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/screens/company/update_project_page.dart';
import 'package:student_hub_flutter/screens/views/chat_list_view.dart';
import 'package:student_hub_flutter/screens/views/project_detail_view.dart';
import 'package:student_hub_flutter/screens/company/project_hired_view.dart';
import 'package:student_hub_flutter/screens/company/project_proposal_view.dart';
import 'package:student_hub_flutter/widgets.dart';

class CompanyProjectPage extends StatefulWidget {
  final Project project;

  const CompanyProjectPage(this.project, {super.key});

  @override
  State<CompanyProjectPage> createState() => _CompanyProjectPageState();
}

class _CompanyProjectPageState extends State<CompanyProjectPage> {
  late Project _project;

  @override
  void initState() {
    super.initState();
    _project = widget.project;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: PageScreen(
        title: _project.title,
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
                onPressed: () => context.pushRoute((context) => UpdateProjectPage(
                  _project,
                  onProjectUpdated: (project) => setState(() => _project = project),
                )),
                child: const IconText(Icons.edit, "Update project")
              ),
              if (_project.status == ProjectStatus.working) MenuItemButton(
                onPressed: () => _closeProject(context),
                child: const IconText(Icons.check, "Close project")
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
            ProjectProposalView(_project),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
                child: ProjectDetailView(_project),
              ),
            ),
            ChatListView(
              hasSearchBar: false,
              chatGetter: _getChats
            ),
            ProjectHiredView(_project),
          ],
        ),
      ),
    );
  }

  Future<List<Message>> _getChats() async {
    var chats = await client.getAllChat(projectId: _project.id);

    for (var chat in chats) {
      chat.project = _project;
    }

    return chats;
  }

  void _deleteProject(BuildContext context) {
    context.loadWithDialog(
      deleteProject(_project.id),
      onDone: (data) => Navigator.pop(context)
    );
  }

  Future<void> _closeProject(BuildContext context) async {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return _CloseProjectDialog(
          onDonePressed: (isSuccessful) => _onDonePressed(context, isSuccessful),
        );
      }
    );
  }

  void _onDonePressed(BuildContext context, bool isSuccessful) async {
    _project.status = isSuccessful ? ProjectStatus.successful : ProjectStatus.failed;
    _project.type = ProjectType.archived;

    context.loadWithDialog(
      client.updateProject(_project),
      onDone: (data) {
        Navigator.pop(context);
        setState(() {});
      },
      onError: (error) => Navigator.pop(context),
    );
  }
}

class _CloseProjectDialog extends StatefulWidget {
  final void Function(bool isSuccessful)? onDonePressed;

  const _CloseProjectDialog({this.onDonePressed});

  @override
  State<_CloseProjectDialog> createState() => _CloseProjectDialogState();
}

class _CloseProjectDialogState extends State<_CloseProjectDialog> {
  bool _isSuccessful = true;

  @override
  Widget build(BuildContext context) {
    return CancelDoneDialog(
      title: "Is this project a...",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          ListTile(
            leading: Radio(
              value: true,
              groupValue: _isSuccessful,
              onChanged: (value) => setState(() => _isSuccessful = value ?? true),
            ),
            title: const Text("Success"),
          ),
          ListTile(
            leading: Radio(
              value: false,
              groupValue: _isSuccessful,
              onChanged: (value) => setState(() => _isSuccessful = value ?? false),
            ),
            title: const Text("Failure"),
          )
        ],
      ),
      onDone: () => widget.onDonePressed?.call(_isSuccessful),
    );
  }
}