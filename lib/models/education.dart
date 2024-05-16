import 'package:student_hub_flutter/models/category.dart';

class Education extends Category {
  int startYear = -1;
  int endYear = -1;

  Education();

  Education.fromJson(super.json) :
    startYear = json["startYear"] ?? -1,
    endYear = json["endYear"] ?? -1,
    super.fromJson(name: json["schoolName"] ?? "");

  String get schoolName => super.name;
}