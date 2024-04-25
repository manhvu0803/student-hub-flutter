import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/string_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/widgets.dart';

class ProjectDetailView extends StatelessWidget {
  final Project project;

  const ProjectDetailView(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TitleText("Description"),
              const Divider(),
              Text(
                project.description,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleText("Details"),
              Divider(),
            ],
          ),
        ),
        _DetailTile(
          icon: Icons.calendar_month,
          title: "Scope",
          content: project.scope.description,
        ),
        const SizedBox(height: 12),
        _DetailTile(
          icon: Icons.people,
          title: "Student required",
          content: (project.numberOfStudents > 0) ? project.numberOfStudents.toString() : "Any"
        ),
        const SizedBox(height: 12),
        _DetailTile(
          icon: Icons.donut_large,
          title: "Progress",
          content: project.type.name.uppercaseFirstLetter
        ),
        const SizedBox(height: 12),
        _DetailTile(
          icon: Icons.star,
          title: "Status",
          content: project.status.name.uppercaseFirstLetter
        ),
      ],
    );
  }
}

class _DetailTile extends StatelessWidget {
  final IconData? icon;

  final String title;

  final String content;

  const _DetailTile({
    this.icon,
    required this.title,
    required this.content
  });

  @override
  Widget build(BuildContext context) {
    var titleStyle = Theme.of(context).textTheme.titleMedium;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            const SizedBox(height: 8),
            Flexible(
              child: ListTile(
                leading: Icon(icon, size: 30),
                title: Text(
                  title,
                  style: titleStyle
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                content,
                style: context.textTheme.bodyLarge
              ),
            )
          ]
        ),
      ),
    );
  }
}