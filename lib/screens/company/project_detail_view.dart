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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TitleText("Info"),
                const Divider(),
                Text(
                  project.description,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _DetailTile(
            icon: Icons.calendar_month,
            title: "Scope",
            content: project.scope.description,
          ),
          _DetailTile(
            icon: Icons.people,
            title: "Student required",
            content: (project.numberOfStudent > 0) ? project.numberOfStudent.toString() : "Any"
          ),
          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TitleText("Status"),
                Divider(),
              ],
            ),
          ),
          _DetailTile(
            icon: Icons.donut_large,
            title: "Progress",
            content: project.status.name.uppercaseFirstLetter
          ),
        ],
      )
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