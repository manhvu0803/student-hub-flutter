import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/widgets.dart';
import 'package:student_hub_flutter/client.dart' as client;

class StudentProfilePage extends StatelessWidget {
  final StudentUser student;

  const StudentProfilePage(this.student, {super.key});

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      title: "Student profile",
      actions: const [],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        child: RefreshableFutureBuilder(
          fetcher: () => client.getUserInfo(),
          builder: _build,
        ),
      ),
    );
  }

  Widget _build(BuildContext context, User user) {
    return ListView(
      children: [
        // Tech stack
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleText("Tech stack"),
            const Spacer(),
            Text(
              student.techStack?.name ?? "",
              style: Theme.of(context).textTheme.bodyLarge
            )
          ]
        ),
        const SizedBox(height: 30),

        // Skill set
        const AddableTitle("Skills"),
        Wrap(children: student.skillSet.mapToList((skill) => SkillButton(skill.name))),
        const SizedBox(height: 30),

        // Languages
        AddableList(
          "Languages",
          listTiles: student.languages.mapToList((language) => SkillListTile(
            language.name,
            subtitle: language.level
          ))
        ),

        // Educations
        AddableList(
          "Educations",
          listTiles: student.educations.mapToList((education) => SkillListTile(
            education.schoolName,
            subtitle: "${education.startYear} - ${education.endYear}",
          )),
        ),

        // Experiences
        AddableList(
          "Experiences",
          listTiles: student.experiences.mapToList((experience) {
            var timeString = "${experience.startTime.toMonthString()} - ${experience.endTime.toMonthString()}";
            var description = experience.description.isNotEmpty ? "\n${experience.description}" : "";

            return SkillListTile(
              experience.title,
              subtitle: "$timeString$description",
            );
          })
        ),
      ],
    );
  }
}