import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/language.dart';
import 'package:student_hub_flutter/models/student_user.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';
import 'package:student_hub_flutter/client/client.dart' as client;
import 'package:student_hub_flutter/client/student_client.dart' as client;
import 'package:student_hub_flutter/widgets/skill_button.dart';
import '../../widgets/title_text.dart';
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
      customActions: [
        TextButton(
          onPressed: () => _saveChanges(context),
          child: const Text("Save changes")
        )
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        child: ListView(
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
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
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
            _AddableTitle(
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
            _AddableList(
              "Language",
              listTiles: _user.languages.mapToList((language) => _SkillListTile(
                language.name,
                subtitle: language.level,
                onMorePressed: () => showAdaptiveDialog(
                  context: context,
                  builder: (context) => ModifyLanguageDialog(
                    title: "Modify language skill",
                    language: language,
                    onDone: (newLanguage) => _modifyUserLanguage(language, newLanguage),
                    onDelete: () => setState(() => _user.languages.remove(language)),
                  )
                )
              )),
              onAddPressed: () => showAdaptiveDialog(
                context: context,
                builder: (context) => ModifyLanguageDialog(
                  title: "Add language",
                  onDone: (newLanguage) => _modifyUserLanguage(newLanguage, newLanguage),
                )
              ),
            ),

            // Educations
            _AddableList(
              "Education",
              listTiles: _user.educations.mapToList((education) => _SkillListTile(
                education,
                onMorePressed: () => _user.educations.remove(education),
              )),
              onAddPressed: () {},
            ),

            // Experiences
            _AddableList(
              "Experiences",
              listTiles: _user.experiences.mapToList((experience) => _SkillListTile(
                experience,
                onMorePressed: () => _user.experiences.remove(experience),
              )),
              onAddPressed: () {},
            ),
          ],
        ),
      ),
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

  void _modifyUserLanguage(Language oldLanguage, Language newLanguage) {
    setState(() {
      _user.languages.remove(oldLanguage);
      _user.languages.add(newLanguage);
    });
  }
}

class _AddableList extends StatelessWidget {
  final String title;
  final Iterable<Widget> listTiles;
  final void Function()? onAddPressed;

  _AddableList(this.title, {this.onAddPressed, Iterable<Widget>? listTiles}) :
    listTiles = listTiles ?? [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AddableTitle(title, onAddPressed: onAddPressed),
        ...listTiles,
        const Divider(),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _AddableTitle extends StatelessWidget {
  final String title;
  final void Function()? onAddPressed;

  const _AddableTitle(this.title, {this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleText(title),
        const Spacer(),
        IconButton(
          onPressed: onAddPressed,
          icon: const Icon(Icons.add)
        )
      ],
    );
  }
}

class _SkillListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final void Function()? onMorePressed;

  const _SkillListTile(this.title, {this.onMorePressed, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: context.textTheme.bodyLarge
      ),
      subtitle: Opacity(
        opacity: 0.8,
        child: (subtitle == null) ? null : Text(subtitle!)
      ),
      trailing: IconButton(
        onPressed: onMorePressed,
        icon: const Icon(Icons.more_horiz)
      )
    );
  }
}