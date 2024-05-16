import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';

class SkillListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final void Function()? onMorePressed;

  const SkillListTile(this.title, {super.key, this.onMorePressed, this.subtitle});

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
      trailing: (onMorePressed == null) ? null : IconButton(
        onPressed: onMorePressed,
        icon: const Icon(Icons.more_horiz)
      )
    );
  }
}