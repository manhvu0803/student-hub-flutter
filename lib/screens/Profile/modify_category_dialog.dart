import 'package:flutter/material.dart';

class ModifyCategoryDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final void Function()? onCancel;
  final void Function()? onDelete;
  final void Function()? onDone;

  const ModifyCategoryDialog({
    super.key,
    required this.title,
    required this.content,
    this.onDone,
    this.onDelete,
    this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: content,
      actions: [
        if (onCancel != null) TextButton(
          onPressed: () {
            Navigator.pop(context);
            onCancel?.call();
          },
          child: const Text("Cancel")
        ),
        if (onDelete != null) TextButton(
          onPressed: () {
            Navigator.pop(context);
            onDelete?.call();
          },
          child: const Text("Delete"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onDone?.call();
          },
          child: const Text("Done")
        )
      ],
    );
  }
}