import 'package:flutter/material.dart';

class HorizontalTitleTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final double distance;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  const HorizontalTitleTextField({
    super.key,
    required this.title,
    this.hintText = "",
    this.distance = 8,
    this.onChanged,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(title),
        ),
        SizedBox(width: distance),
        Expanded(
          child: TextField(
            onChanged: onChanged,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(fontStyle: FontStyle.italic)
            )
          ),
        ),
      ]
    );
  }
}
