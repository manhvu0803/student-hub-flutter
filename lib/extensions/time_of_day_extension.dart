import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String to24HourString({String seperator = ":"}) => "$hour$seperator$_minuteString";

  String to12HourString({String seperator = ":"}) => "${hour % 12}$seperator$_minuteString ${(hour < 12) ? "AM" : "PM"}";

  String get _minuteString => "${(minute < 10) ? "0" : ""}$minute";
}