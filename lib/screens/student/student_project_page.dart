import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client.dart' as client;
import 'package:student_hub_flutter/client/student_client.dart' as client;
import 'package:student_hub_flutter/client/project_client.dart' as client;
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/durtaion_extension.dart';
import 'package:student_hub_flutter/models.dart';
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
      child: RefreshableFutureBuilder(
        fetcher: () => client.getProject(widget.project.id),
        builder: (context, project) {
          userProposal ??= _getUserProposal(project);

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: _ProjectInfoView(project, userProposal),
              ),
              if (userProposal != null) _getProposalCard(context),
              if (userProposal == null) _getApplyButton(context)
            ],
          );
        },
      ),
    );
  }

  Padding _getApplyButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 42.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 170,
          height: 60,
          child: FilledButton(
            onPressed: () => _showApplyDialog(context),
            child: const Text(
              "Apply",
              style: TextStyle(fontSize: 18),
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
                controller: TextEditingController()..text = userProposal!.content,
                decoration: const InputDecoration(
                  hintText: "Your proposal..."
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

class _ProjectInfoView extends StatelessWidget {
  final Project project;
  final Proposal? proposal;

  const _ProjectInfoView(this.project, this.proposal);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      // Title
      const SizedBox(height: 22),
      Text(
        project.title,
        style: context.textTheme.displaySmall,
      ),
      const SizedBox(height: 32),
      // Company
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: "From ",
                style: context.textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: project.company?.name ?? "unknown company",
                    style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)
                  )
                ]
              ),
            ),
            const Spacer(),
            Opacity(
              opacity: 0.8,
              child: Text("${DateTime.now().difference(project.createdAt).toShortString()} ago")
            ),
          ]
        ),
      ),
      const SizedBox(height: 32),
      // Description
      const TitleText("Description"),
      const SizedBox(height: 10),
      Text(
        project.description,
        style: context.textTheme.bodyLarge,
        textAlign: TextAlign.justify,
      ),
      const SizedBox(height: 32),
      // Scope
      const TitleText("Scope"),
      const SizedBox(height: 12),
      Text(
        project.scope.description,
        style: const TextStyle(fontSize: 18),
      ),
      const SizedBox(height: 32),
    ]);
  }
}