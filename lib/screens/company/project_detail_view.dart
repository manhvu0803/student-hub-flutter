import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';

class ProjectDetailView extends StatelessWidget {
  const ProjectDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Student are looking for",
                  style: context.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  "- Clear expectation\n- Skill required\n- Project detail",
                  style: context.textTheme.titleMedium
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          const _DetailTile(
            icon: Icons.calendar_month,
            title: "Scope",
            content: "3 - 6 month",
          ),
          const _DetailTile(
            icon: Icons.people,
            title: "Student required",
            content: "6 students",
          )
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
    );
  }
}