import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/screens/student/student_project_page.dart';
import 'package:student_hub_flutter/widgets/project_card.dart';

class StudentProjectCard extends StatefulWidget {
  final Project project;
  final void Function()? onPop;

  const StudentProjectCard(this.project, {super.key, this.onPop});

  @override
  State<StudentProjectCard> createState() => _StudentProjectCardState();
}

class _StudentProjectCardState extends State<StudentProjectCard> {
  late Project _project;

  @override
  void initState() {
    super.initState();
    _project = widget.project;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ProjectCard.fromProject(
        widget.project,
        onPressed: () => context.pushRoute(
          (context) => StudentProjectPage(_project),
          onPop: widget.onPop
        ),
        bottom: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            "Length: ${widget.project.scope.description}\nRequired ${widget.project.numberOfStudents} student(s)",
            maxLines: 2,
            overflow: TextOverflow.fade,
          ),
        ),
        trailing: !widget.project.isFavorite ? null : Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(
            widget.project.isFavorite ? Icons.favorite : Icons.favorite_outline,
            color: Colors.red
          ),
        ),
      ),
    );
  }
}