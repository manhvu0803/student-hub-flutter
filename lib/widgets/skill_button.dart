import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';

class SkillButton extends StatelessWidget {
  final String name;
  final bool isEnabled;
  final void Function()? onPressed;

  const SkillButton(this.name, {super.key, this.isEnabled = true, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: onPressed,
        child: Ink(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: isEnabled ? context.colorScheme.tertiaryContainer : Colors.black12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ],
          ),
        ),
      ),
    );
  }
}