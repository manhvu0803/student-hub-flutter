import 'package:flutter/material.dart';

class CancelDoneDialog extends StatelessWidget {
  final String title;
  final String doneString;
  final Widget? content;
  final void Function()? onCancel;
  final void Function()? onDone;

  const CancelDoneDialog({
    super.key,
    required this.title,
    this.doneString = "Apply",
    this.onCancel,
    this.onDone,
    this.content
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(title),
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onCancel?.call();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: onDone,
          child: Text(doneString),
        )
      ],
    );
  }
}