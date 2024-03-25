import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color get inverse => Color.fromARGB(alpha, 255 - red, 255 - green, 255 - blue);
}