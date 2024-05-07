import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/category.dart';

class Experience extends Category {
  static _getSkillSet(Map<String, dynamic> json) {
    var list = (json["skillSets"] ?? json["skillSet"] ?? []) as List;
    return list.mapToList((item) => Category.fromJson(item));
  }

  static DateTime _parseMonth(String monthString) {
    var now = DateTime.now();

    try {
      var strings = monthString.split("-");
      return DateTime(int.tryParse(strings[1]) ?? now.year, int.tryParse(strings[0]) ?? now.month);
    }
    catch (e) {
      print(e);
    }

    return DateTime(now.year, now.month);
  }

  DateTime startTime;
  DateTime endTime;
  String description = "";
  List<Category> skillSet;

  Experience({
    required this.startTime,
    required this.endTime,
    required this.skillSet
  });

  Experience.fromJson(super.json) :
    startTime = _parseMonth(json["startMonth"] ?? ""),
    endTime = _parseMonth(json["endMonth"] ?? ""),
    description = json["description"] ?? "",
    skillSet = _getSkillSet(json),
    super.fromJson(name: json["title"] ?? "");

  String get title => super.name;
}