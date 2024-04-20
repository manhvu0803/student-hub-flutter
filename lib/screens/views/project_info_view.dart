import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/duration_extension.dart';
import 'package:student_hub_flutter/models.dart';

class ProjectInfoView extends StatelessWidget {
  final Project project;

  const ProjectInfoView(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        Text(
          project.title,
          style: context.textTheme.displaySmall,
        ),
        const SizedBox(height: 8),
        // Company
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: "From ",
                  style: context.textTheme.bodyLarge,
                  children: [
                    TextSpan(
                      text: project.company?.name ?? "unknown company",
                      style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)
                    )
                  ]
                ),
              ),
              const Spacer(),
              Opacity(
                opacity: 0.8,
                child: Text("${DateTime.now().difference(project.createdAt).toShortString()} ago")
              ),
            ]
          ),
        )
      ]
    );
  }
}