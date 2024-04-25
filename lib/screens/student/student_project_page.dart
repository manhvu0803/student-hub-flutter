import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client.dart' as client;
import 'package:student_hub_flutter/client/student_client.dart' as client;
import 'package:student_hub_flutter/client/project_client.dart' as client;
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/screens/views/project_detail_view.dart';
import 'package:student_hub_flutter/screens/views/project_info_view.dart';
import 'package:student_hub_flutter/widgets.dart';

class StudentProjectPage extends StatefulWidget {
  final Project project;

  const StudentProjectPage(this.project, {super.key});

  @override
  State<StudentProjectPage> createState() => _StudentProjectPageState();
}

class _StudentProjectPageState extends State<StudentProjectPage> {
  static Proposal? _getUserProposal(Project project) {
    for (var proposal in project.proposals) {
      if (proposal.studentId == client.user!.student!.id) {
        return proposal;
      }
    }

    return null;
  }

  String _proposalContent = "";
  Proposal? userProposal;

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      title: "Apply for project",
      actions: [IconButton(
        onPressed: () => _onToggleFavorite(context),
        icon: Icon(
          widget.project.isFavorite ? Icons.favorite : Icons.favorite_outline,
          color: Colors.red
        ),
      )],
      child: RefreshableFutureBuilder(
        fetcher: () => client.getProject(widget.project.id),
        builder: (context, project) {
          userProposal ??= _getUserProposal(project);

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: ProjectInfoView(project),
                    ),
                    const SizedBox(height: 32),
                    ProjectDetailView(project),
                    const SizedBox(height: 200),
                  ],
                ),
              ),
              if (userProposal != null) _getProposalCard(context),
              if (userProposal == null) _getApplyButton(context)
            ],
          );
        },
      ),
    );
  }


  void _onToggleFavorite(BuildContext context) async {
    try {
      await client.setFavorite(widget.project.id, !widget.project.isFavorite);
      setState(() => widget.project.isFavorite = !widget.project.isFavorite);
    }
    catch (e) {
      if (context.mounted) {
        context.showTextSnackBar(e.toString());
      }
    }
  }

  Padding _getApplyButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 42.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 170,
          height: 60,
          child: FloatingActionButton(
            onPressed: () => _showApplyDialog(context),
            child: const Text(
              "Apply",
              style: TextStyle(fontSize: 20),
            )
          ),
        ),
      ),
    );
  }

  Widget _getProposalCard(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 29, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TitleText("Your proposal"),
                  const Spacer(),
                  TextButton(
                    onPressed: () => _showApplyDialog(context),
                    child: const IconText(
                      Icons.edit,
                      "Edit",
                      reversed: true,
                      distance: 5,
                      iconSize: 16,
                    )
                  )
                ],
              ),
              const SizedBox(height: 4),
              Text(
                userProposal!.content,
                style: context.textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showApplyDialog(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text((userProposal == null) ? "Apply for project" : "Edit proposal"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController()..text = userProposal?.content ?? "",
                decoration: const InputDecoration(
                  hintText: "Your proposal...",
                ),
                maxLines: null,
                onChanged: (value) => _proposalContent = value,
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")
            ),
            TextButton(
              onPressed: () => _onApply(context),
              child: const Text("Apply")
            )
          ],
        );
      }
    );
  }

  void _onApply(BuildContext context) async {
    context.showLoadingDialog();

    try {
      if (userProposal == null) {
        userProposal = await client.applyForProject(
          projectId: widget.project.id,
          proposal: _proposalContent
        );
      }
      else {
        userProposal!.content = _proposalContent;
        await client.patchProposal(userProposal!);
      }

      setState(() {});
    }
    catch (e) {
      if (context.mounted) {
        context.showTextSnackBar(e.toString());
      }
    }

    if (context.mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}