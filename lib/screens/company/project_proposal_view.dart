import 'package:flutter/material.dart';

class ProjectProposalView extends StatelessWidget {
  const ProjectProposalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: const [
          _ProposalCard(
            studentName: "Quan Nguyen",
            avatarUrl: "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
            education: "4th year",
            specialty: "Backend Engineer",
            evaluation: "Excellent",
            proposal: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          ),
          SizedBox(height: 8),
          _ProposalCard(
            studentName: "Quan Nguyen",
            avatarUrl: "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
            education: "4th year",
            specialty: "Backend Engineer",
            evaluation: "Excellent",
            proposal: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          ),
        ],
      ),
    );
  }
}

class _ProposalCard extends StatelessWidget {
  final String studentName;

  final String avatarUrl;

  final String education;

  final String specialty;

  final String evaluation;

  final String proposal;

  const _ProposalCard({
    required this.studentName,
    required this.avatarUrl,
    required this.education,
    required this.specialty,
    required this.evaluation,
    required this.proposal
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            ListTile(
              leading: Image.network(avatarUrl),
              title: Text(studentName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(education),
                  Text(specialty),
                ],
              ),
              trailing: Text(evaluation),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                proposal,
                maxLines: 2,
                overflow: TextOverflow.ellipsis
              ),
            ),
            const SizedBox(height: 16),
            Theme(
              data: Theme.of(context).copyWith(
                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(130, 0)
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
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}