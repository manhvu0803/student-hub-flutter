import 'package:flutter/material.dart';
import 'package:student_hub_flutter/widgets/addable_title.dart';

class AddableList extends StatelessWidget {
  final String title;
  final Iterable<Widget> listTiles;
  final void Function()? onAddPressed;

  AddableList(this.title, {super.key, this.onAddPressed, Iterable<Widget>? listTiles}) :
    listTiles = listTiles ?? [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddableTitle(title, onAddPressed: onAddPressed),
        ...listTiles,
        const Divider(),
        const SizedBox(height: 30),
      ],
    );
  }
}
