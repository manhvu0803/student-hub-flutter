import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final String text;
  final double distance;
  final bool reversed;
  final TextStyle? textStyle;

  const IconText(
    this.icon,
    this.text,
  {
    super.key,
    this.reversed = false,
    this.distance = 5,
    this.iconSize,
    this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    var iconWidget = Icon(icon, size: iconSize);
    var textWidget = Text(text, style: textStyle);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        reversed ? textWidget : iconWidget,
        SizedBox(width: distance),
        reversed ? iconWidget : textWidget,
      ],
    );
  }
}