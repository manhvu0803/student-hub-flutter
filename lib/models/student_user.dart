import 'dart:io';

import './category.dart';

class StudentUser {
  static List<Category> _getSkillSet(List<dynamic> json) {
    var skillSets = <Category>[];

    for (var innerJson in json) {
      skillSets.add(Category.fromJson(innerJson));
    }

    return skillSets;
  }

  int id = -1;
  String name = '';
  Category techStack = Category();
  List<Category> skillSet = [];
  late File cv;
  late File transcript;

  StudentUser();

  StudentUser.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    name = json["name"] ?? json["Name"] ?? "",
    techStack = Category.fromJson(json["techStack"] ?? json["TechStack"]),
    skillSet = _getSkillSet(json["skillSets"] ?? json["SkillSets"] ?? json["skillets"] ?? json["Skillsets"]);
}
