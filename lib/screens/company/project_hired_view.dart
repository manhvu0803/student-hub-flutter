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
          ..id = proposal.student?.id ?? proposal.studentId
      ))
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String studentName;
  final Widget? avatar;
  final String education;
  final String specialty;
  final String evaluation;
  final String proposal;
  final void Function()? onMessagePressed;

  const _InfoCard({
    required this.studentName,
    required this.avatar,
    required this.education,
    required this.specialty,
    required this.evaluation,
    required this.proposal,
    // ignore: unused_element
    this.onMessagePressed
  });

  _InfoCard.fromProposal(Proposal proposal, {this.avatar, this.onMessagePressed}) :
    studentName = proposal.student!.name,
    education = proposal.student!.educationString,
    specialty = proposal.student!.techStack?.name ?? "Engineer",
    evaluation = "Excellence",
    proposal = proposal.content;

  @override
  Widget build(BuildContext context) {
    return ProposalCard.studentProposal(
      studentName: studentName,
      avatar: avatar ?? const CircleAvatar(child: Icon(Icons.person)),
      education: education,
      specialty: specialty,
      evaluation: evaluation,
      proposal: proposal,
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