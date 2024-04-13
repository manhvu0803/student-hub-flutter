import 'package:flutter/material.dart';
import 'package:student_hub_flutter/models/language.dart';
import 'package:student_hub_flutter/screens/profile/modify_category_dialog.dart';

class ModifyLanguageDialog extends StatefulWidget {
  final String title;
  final void Function()? onDelete;
  final void Function(Language)? onDone;
  final Language? language;

  const ModifyLanguageDialog({
    super.key,
    this.onDone,
    required this.title,
    this.onDelete,
    this.language
  });

  @override
  State<ModifyLanguageDialog> createState() => _ModifyLanguageDialogState();
}

class _ModifyLanguageDialogState extends State<ModifyLanguageDialog> {
  late Language _language;
  late TextEditingController _nameTextController;
  late TextEditingController _levelTextController;

  @override
  void initState() {
    super.initState();
    _language = widget.language ?? Language();
    _nameTextController = TextEditingController()..text = _language.name;
    _levelTextController = TextEditingController()..text = _language.level;
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _levelTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModifyCategoryDialog(
      title: widget.title,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Language", style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(controller: _nameTextController),
          const SizedBox(height: 10),
          const Text("Level", style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(controller: _levelTextController)
        ]
      ),
      onCancel: () {},
      onDelete: widget.onDelete,
      onDone: () {
        _language.name = _nameTextController.text;
        _language.level = _levelTextController.text;
        Navigator.pop(context);
        widget.onDone?.call(_language);
      },
    );
  }
}