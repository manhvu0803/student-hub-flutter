import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/category.dart';
import 'package:student_hub_flutter/models/student_user.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';
import 'package:student_hub_flutter/client/client.dart' as client;
import 'package:student_hub_flutter/client/student_client.dart' as client;

class StudentProfileBasic extends StatefulWidget {
  const StudentProfileBasic({super.key});

  @override
  State<StudentProfileBasic> createState() => _StudentProfileBasic();
}

class _StudentProfileBasic extends State<StudentProfileBasic> {
  late StudentUser user;

  @override
  void initState() {
    super.initState();
    user = client.user?.student ?? StudentUser();
  }

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      title: "Student profile",
      useTrailingButton: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Tech stack
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _TitleText("Tech stack"),
                const Spacer(),
                DropdownButton(
                  value: user.techStack,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (value) => setState(() => user.techStack = value),
                  items: _getTeckStackDropdownItems(context),
                )
              ]
            ),
            const SizedBox(height: 30),

            // Skill set
            _AddableTitle(
              "Skills",
              onAddPressed: () {},
            ),
            const SizedBox(height: 10),
            Wrap(children: _getSkillButtons()),
            const SizedBox(height: 30),

            // Languageset
            _AddableTitle(
              "Language",
              onAddPressed: () {},
            ),
            ..._getLanguagesTiles(),
            const Divider(),
            const SizedBox(height: 30),

            // Educations
            _AddableTitle(
              "Education",
              onAddPressed: () {},
            ),
            ..._getEducationTiles(),
            const Divider(),
            const SizedBox(height: 30),

            // Experiences
            _AddableTitle(
              "Experiences",
              onAddPressed: () {},
            ),
            ..._getExperiencesTiles(),
            const Divider(),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<Category>> _getTeckStackDropdownItems(BuildContext context) {
    return client.techStacks.values.mapToList((techStack) {
      return DropdownMenuItem(
        value: techStack,
        child: Text(
          techStack.name,
          style: Theme.of(context).textTheme.bodyLarge
        )
      );
    });
  }

  List<Widget> _getSkillButtons() {
    var skills = user.skillSet;
    return skills.mapToList((skill) => _SkillButton(skill.name));
  }

  List<Widget> _getLanguagesTiles() {
    return user.languages.mapToList((language) => _SkillListTile(
      language.name,
      subtitle: language.level,
      onRemovePressed: () {},
    ));
  }

  List<Widget> _getEducationTiles() {
    return user.educations.mapToList((education) => _SkillListTile(
      education,
      onRemovePressed: () {},
    ));
  }

  List<Widget> _getExperiencesTiles() {
    return user.experiences.mapToList((experience) => _SkillListTile(
      experience,
      onRemovePressed: () {},
    ));
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
        _TitleText(title),
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
  final void Function()? onRemovePressed;

  const _SkillListTile(this.title, {this.onRemovePressed, this.subtitle});

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
        onPressed: onRemovePressed,
        icon: const Icon(Icons.delete)
      )
    );
  }
}

class _SkillButton extends StatefulWidget {
  final String name;
  final bool togglable;

  const _SkillButton(this.name, {this.togglable = false});

  @override
  State<_SkillButton> createState() => _SkillButtonState();
}

class _SkillButtonState extends State<_SkillButton> {
  bool _isEnable = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: _onTap,
        child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: _isEnable ? context.colorScheme.tertiaryContainer : context.colorScheme.errorContainer,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.name,
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() {
    if (widget.togglable) {
      setState(() => _isEnable = !_isEnable);
    }
  }
}

class _TitleText extends StatelessWidget {
  final String text;

  const _TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
    );
  }
}