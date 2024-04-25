import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/screens/company/company_project_page.dart';
import 'package:student_hub_flutter/widgets/project_card.dart';

class CompanyProjectCard extends StatelessWidget {
  static const int _extraInfoLimit = 2;
  final Project project;
  final void Function()? onPop;

  const CompanyProjectCard(this.project, {super.key, this.onPop});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4.0),
      child: ProjectCard.fromProject(
        project,
        onPressed: () => context.pushRoute(
          (context) => CompanyProjectPage(project),
          onPop: onPop
        ),
        contentBottom: _getRequestWidget(context),
        bottom: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${project.proposalCount} proposal${(project.proposalCount > 1) ? "s" : ""}"),
              Text("${project.messageCount} message${(project.messageCount > 1) ? "s" : ""}"),
              Text("${project.hireCount} hired")
            ]
          ),
        ),
      )
    );
  }

  Widget? _getRequestWidget(BuildContext context) {
    if (project.proposals.isEmpty) {
      return null;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            "Student that is applying",
            style: context.textTheme.titleMedium,
          ),
          ..._getApplyingStudents(context)
        ],
      ),
    );
  }

  Iterable<Widget> _getApplyingStudents(BuildContext context) {
    var widgets = <Widget>[];
    var proposals = project.proposals;

    for (int i = 0; i < proposals.length && i < _extraInfoLimit; i++) {
      widgets.add(Text(
        " - ${proposals[i].student!.name}",
        style: context.textTheme.bodyMedium,
      ));
    }

    if (proposals.length > _extraInfoLimit) {
      widgets.add(Text(
        " - ...",
        style: context.textTheme.bodyMedium,
      ));
    }

    return widgets;
  }
}