import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final double distance;

  const IconText(
    this.icon,
    this.text,
  {
    super.key,
    this.distance = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: distance),
        Text(text),
      ],
    );
  }
}