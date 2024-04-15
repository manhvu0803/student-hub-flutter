import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/models/project.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime createTime;
  final DateTime? updateTime;
  final Widget? leading;
  final Widget? trailing;
  final Widget? contentBottom;
  final Widget? bottom;
  final void Function()? onPressed;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.createTime,
    this.updateTime,
    this.contentBottom,
    this.bottom,
    this.leading,
    this.trailing,
    this.onPressed,
  });

  ProjectCard.fromProject(Project project, {
    super.key,
    this.contentBottom,
    this.bottom,
    this.leading,
    this.trailing,
    this.onPressed
  }) :
    title = project.title,
    description = project.description,
    createTime = project.createdAt,
    updateTime = project.updatedAt ?? project.createdAt;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Row(
          children: [
            if (leading != null) leading!,
            Expanded(child: _getMainColumn(context)),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }

  Widget _getMainColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: context.textTheme.titleMedium,
              ),
              Text(
                _timeText,
                style: TextStyle(color: context.textTheme.titleMedium!.color!.withAlpha(255 ~/ 1.5)),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              if (contentBottom != null) contentBottom!,
            ]
          ),
        ),
        if (bottom != null) bottom!,
        const SizedBox(height: 16),
      ],
    );
  }

  String get _timeText {
    var text = "Created ${createTime.toDateString()}";

    if (updateTime != null) {
      text += " - Updated ${updateTime!.toDateString()}";
    }

    return text;
  }
}