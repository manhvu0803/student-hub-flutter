import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/screens/profile/modify_education_dialog.dart';
import 'package:student_hub_flutter/screens/profile/modify_experience_dialog.dart';
import 'package:student_hub_flutter/widgets.dart';
import 'package:student_hub_flutter/client.dart' as client;
import 'package:student_hub_flutter/client/student_client.dart' as client;
import 'modify_language_dialog.dart';
import 'skill_dialog.dart';

class StudentProfileBasic extends StatefulWidget {
  const StudentProfileBasic({super.key});

  @override
  State<StudentProfileBasic> createState() => _StudentProfileBasic();
}

class _StudentProfileBasic extends State<StudentProfileBasic> {
  late StudentUser _user;

  @override
  void initState() {
    super.initState();
    _user = client.user?.student ?? StudentUser();
  }

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      title: "Student profile",
      actions: [
        TextButton(
          onPressed: () => _saveChanges(context),
          child: const Text("Save changes")
        )
      ],
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
            DropdownButton(
              value: _user.techStack,
              elevation: 16,
              onChanged: (value) => setState(() => _user.techStack = value),
              items: client.techStacks.values.mapToList((techStack) => DropdownMenuItem(
                value: techStack,
                child: Text(
                  techStack.name,
                  style: Theme.of(context).textTheme.bodyLarge
                )
              )),
            )
          ]
        ),
        const SizedBox(height: 30),

        // Skill set
        AddableTitle(
          "Skills",
          onAddPressed: () => showAdaptiveDialog(
            context: context,
            builder: (context) => SkillDialog(
              chosenSkills: _user.skillSet,
              onDoneChoosing: (skills) => setState(() => _user.skillSet = skills)
            )
          ),
        ),
        Wrap(children: _user.skillSet.mapToList((skill) => SkillButton(skill.name))),
        const SizedBox(height: 30),

        // Languages
        AddableList(
          "Languages",
          listTiles: _user.languages.mapToList((language) => SkillListTile(
            language.name,
            subtitle: language.level,
            onMorePressed: () => showAdaptiveDialog(
              context: context,
              builder: (context) => ModifyLanguageDialog(
                title: "Modify language skill",
                language: language,
                onDone: (newLanguage) => _modifyUserProfile(language, newLanguage, _user.languages),
                onDelete: () => setState(() => _user.languages.remove(language)),
              )
            )
          )),
          onAddPressed: () => showAdaptiveDialog(
            context: context,
            builder: (context) => ModifyLanguageDialog(
              title: "Add language",
              onDone: (newLanguage) => _modifyUserProfile(newLanguage, newLanguage, _user.languages),
            )
          ),
        ),

        // Educations
        AddableList(
          "Educations",
          listTiles: _user.educations.mapToList((education) => SkillListTile(
            education.schoolName,
            onMorePressed: () => showAdaptiveDialog(
              context: context,
              builder: (context) => ModifyEducationDialog(
                title: "Add education",
                onDone: (newEducation) => _modifyUserProfile(education, newEducation, _user.educations),
                onDelete: () => _user.educations.remove(education),
              ),
            ),
            subtitle: "${education.startYear} - ${education.endYear}",
          )),
          onAddPressed: () => showAdaptiveDialog(
            context: context,
            builder: (context) => ModifyEducationDialog(
              title: "Add education",
              onDone: (education) => _modifyUserProfile(education, education, _user.educations),
            ),
          )
        ),

        // Experiences
        AddableList(
          "Experiences",
          listTiles: _user.experiences.mapToList((experience) {
            var timeString = "${experience.startTime.toMonthString()} - ${experience.endTime.toMonthString()}";
            var description = experience.description.isNotEmpty ? "\n${experience.description}" : "";

            return SkillListTile(
              experience.title,
              onMorePressed: () => showAdaptiveDialog(
                context: context,
                builder: (context) => ModifyExperienceDialog(
                  title: "Add experience",
                  onDone: (newExperience) => _modifyUserProfile(experience, newExperience, _user.experiences),
                  onDelete: () => _user.experiences.remove(experience),
                ),
              ),
              subtitle: "$timeString$description",
            );
          }),
          onAddPressed: () => showAdaptiveDialog(
            context: context,
            builder: (context) => ModifyExperienceDialog(
              title: "Add experience",
              onDone: (experience) => _modifyUserProfile(experience, experience, _user.experiences),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _saveChanges(BuildContext context) async {
    context.showLoadingDialog();

    try {
      await client.updateProfile(_user);
    }
    catch (e) {
      if (context.mounted) {
        context.showTextSnackBar(e.toString());
      }
    }

    if (context.mounted) {
      Navigator.pop(context);
      context.showTextSnackBar(
        "Profile saved",
        duration: const Duration(seconds: 2)
      );
    }
  }

  void _modifyUserProfile<T extends Category>(T oldCategory, T newCategory, List<T> container) {
    if (newCategory.name.isEmpty) {
      return;
    }

    setState(() {
      container.remove(oldCategory);
      container.add(newCategory);
    });
  }
}