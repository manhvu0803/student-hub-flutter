import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/widgets/proposal_card.dart';

class ProjectProposalView extends StatelessWidget {
  const ProjectProposalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: const [
          _HireProposalCard(
            studentName: "Quan Nguyen",
            avatarUrl: "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
            education: "4th year",
            specialty: "Backend Engineer",
            evaluation: "Excellent",
            proposal: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          ),
          SizedBox(height: 8),
          _HireProposalCard(
            studentName: "Quan Nguyen",
            avatarUrl: "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
            education: "4th year",
            specialty: "Backend Engineer",
            evaluation: "Excellent",
            proposal: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis",
          ),
        ],
      ),
    );
  }
}

class _HireProposalCard extends StatelessWidget {
  final String studentName;

  final String avatarUrl;

  final String education;

  final String specialty;

  final String evaluation;

  final String proposal;

  const _HireProposalCard({
    required this.studentName,
    required this.avatarUrl,
    required this.education,
    required this.specialty,
    required this.evaluation,
    required this.proposal
  });

  @override
  Widget build(BuildContext context) {
    return ProposalCard.studentProposal(
      studentName: studentName,
      avatarUrl: avatarUrl,
      education: education,
      specialty: specialty,
      evaluation: evaluation,
      proposal: proposal,
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
              child: const Text("Message"),
              onPressed: () {},
            ),
            OutlinedButton(
              child: const Text("Hire"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}