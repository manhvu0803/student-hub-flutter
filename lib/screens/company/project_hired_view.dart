import 'package:flutter/material.dart';
import 'package:student_hub_flutter/client/project_client.dart' as client;
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/screens/pages/chat_page.dart';
import 'package:student_hub_flutter/widgets/proposal_card.dart';
import 'package:student_hub_flutter/widgets/refreshable_future_builder.dart';

class ProjectHiredView extends StatelessWidget {
  final Project project;

  const ProjectHiredView(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshableFutureBuilder.forCollection(
        emptyString: "No student has been hired for this project",
        fetcher: () => client.getProposals(project.id, statusFilter: ProposalStatus.hired),
        builder: (context, data) => ListView(
          children: _getInfoCards(context, data),
        ),
      ),
    );
  }

  List<Widget> _getInfoCards(BuildContext context, Iterable<Proposal> proposals) {
    return proposals.mapToList((proposal) => _InfoCard.fromProposal(
      proposal,
      onMessagePressed: () => _buildChatPage(context, proposal),
    ));
  }

  Future<void> _buildChatPage(BuildContext context, Proposal proposal) async {
    context.loadWithDialog(
      client.getProject(proposal.projectId),
      onDone: (project) => context.pushRoute((context) => ChatPage(
        project: project,
        recipient: User()
          ..fullName = proposal.student!.name
          ..id = proposal.student!.userId
      ))
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Widget? avatar;
  final String evaluation;
  final void Function()? onMessagePressed;
  final Proposal proposal;

  const _InfoCard({
    required this.avatar,
    required this.evaluation,
    required this.proposal,
    // ignore: unused_element
    this.onMessagePressed
  });

  // ignore: unused_element
  const _InfoCard.fromProposal(this.proposal, {this.avatar, this.onMessagePressed}) :
    evaluation = "Excellence";

  @override
  Widget build(BuildContext context) {
    return ProposalCard.studentProposal(
      proposal,
      avatar: avatar ?? const CircleAvatar(child: Icon(Icons.person)),
      evaluation: evaluation,
      bottom: Align(
        alignment: Alignment.center,
        child: OutlinedButton(
          onPressed: onMessagePressed,
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(130, 0)
          ),
          child: const Text("Message"),
        ),
      ),
    );
  }
}