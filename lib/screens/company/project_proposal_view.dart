import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client/project_client.dart' as client;
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/screens/pages/chat_page.dart';
import 'package:student_hub_flutter/widgets.dart';

class ProjectProposalView extends StatelessWidget {
  final Project project;

  const ProjectProposalView(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshableFutureBuilder(
        fetcher: () => client.getProposals(project.id),
        builder: (context, data) => ListView(
          children: data.mapToList((proposal) => _HireProposalCard.fromProposal(proposal)),
        ),
      ),
    );
  }
}

class _HireProposalCard extends StatelessWidget {
  final Widget? avatar;
  final String evaluation;
  final Proposal proposal;

  const _HireProposalCard({
    required this.avatar,
    required this.evaluation,
    required this.proposal,
  });

  const _HireProposalCard.fromProposal(this.proposal) :
    avatar = const CircleAvatar(child: Icon(Icons.person)),
    evaluation = "Excellence";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12),
      child: ProposalCard.studentProposal(
        studentName: proposal.student!.name,
        avatar: avatar,
        education: proposal.student!.educations.isNotEmpty ? proposal.student!.educations[0].toString() : "No experience",
        specialty: proposal.student!.techStack?.name ?? "Engineer",
        evaluation: evaluation,
        proposal: proposal.content,
        bottom: Theme(
          data: Theme.of(context).copyWith(
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(130, 0),
                backgroundColor: context.colorScheme.surfaceVariant
              )
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () => _buildChatPage(context),
                child: const Text("Message"),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text("Hire"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _buildChatPage(BuildContext context) async {
    context.showLoadingDialog();

    try {
      var project = await client.getProject(proposal.projectId);

      if (context.mounted) {
        Navigator.pop(context);
        context.pushRoute((context) => ChatPage(
          project: project,
          recipient: User()
            ..fullName = proposal.student!.name
            ..id = proposal.student?.id ?? proposal.studentId
        ));
      }
    }
    catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        context.showTextSnackBar(e.toString());
      }
    }
  }
}