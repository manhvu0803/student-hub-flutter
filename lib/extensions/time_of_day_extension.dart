import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String to24HString({String seperator = ":"}) => "$hour$seperator$minute";

  String to12HString({String seperator = ":"}) => "${hour % 12}$seperator$minute ${(hour < 12) ? "AM" : "PM"}";
}