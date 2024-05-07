import 'package:flutter/material.dart';
import 'package:student_hub_flutter/widgets.dart';

class AddableTitle extends StatelessWidget {
  final String title;
  final void Function()? onAddPressed;

  const AddableTitle(this.title, {super.key, this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleText(title),
        const Spacer(),
        if (onAddPressed != null) IconButton(
          onPressed: onAddPressed,
          icon: const Icon(Icons.add)
        )
      ],
    );
  }
}
