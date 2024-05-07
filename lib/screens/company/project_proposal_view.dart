import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client/project_client.dart' as client;
import 'package:student_hub_flutter/client/company_client.dart' as client;
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/screens/pages/chat_page.dart';
import 'package:student_hub_flutter/widgets.dart';

class ProjectProposalView extends StatefulWidget {
  final Project project;

  const ProjectProposalView(this.project, {super.key});

  @override
  State<ProjectProposalView> createState() => _ProjectProposalViewState();
}

class _ProjectProposalViewState extends State<ProjectProposalView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshableFutureBuilder.forCollection(
        emptyString: "No proposal for this project",
        fetcher: () => client.getProposals(widget.project.id, statusFilter: ProposalStatus.waiting),
        builder: (context, data) {
          return ListView(
            children: data.mapToList((proposal) => _HireProposalCard.fromProposal(
              proposal,
              onHirePressed: () => _hire(context, proposal),
            )),
          );
        },
      ),
    );
  }

  Future<void> _hire(BuildContext context, Proposal proposal) async {
    context.loadWithDialog(
      client.hireStudent(proposal.id),
      onDone: (data) {
        context.showTextSnackBar("Hired ${proposal.student!.name}");
        setState(() {});
      }
    );
  }
}

class _HireProposalCard extends StatelessWidget {
  final Widget? avatar;
  final String evaluation;
  final Proposal proposal;
  final void Function()? onHirePressed;

  const _HireProposalCard({
    required this.avatar,
    required this.evaluation,
    required this.proposal,
    // ignore: unused_element
    this.onHirePressed,
  });

  const _HireProposalCard.fromProposal(this.proposal, {this.onHirePressed}) :
    avatar = const CircleAvatar(child: Icon(Icons.person)),
    evaluation = "Excellence";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12),
      child: ProposalCard.studentProposal(
        proposal,
        avatar: avatar,
        evaluation: evaluation,
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
                onPressed: onHirePressed,
                child: const Text("Hire"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _buildChatPage(BuildContext context) async {
    context.loadWithDialog(
      client.getProject(proposal.projectId),
      onDone: (project) => context.pushRoute((context) => ChatPage(
        project: project,
        recipient: User()
          ..fullName = proposal.student!.name
          ..id = proposal.student?.id ?? proposal.studentId
      ))
    );
  }
}