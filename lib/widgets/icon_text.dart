import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final String text;
  final double distance;
  final bool reversed;

  const IconText(
    this.icon,
    this.text,
  {
    super.key,
    this.reversed = false,
    this.distance = 5,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    var iconWidget = Icon(icon, size: iconSize);

    return Row(
      children: [
        reversed ? Text(text) : iconWidget,
        SizedBox(width: distance),
        reversed ? iconWidget : Text(text),
      ],
    );
  }
}