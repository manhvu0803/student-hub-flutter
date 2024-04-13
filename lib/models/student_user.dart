import 'dart:io';
import 'package:student_hub_flutter/models/language.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import './category.dart';

class StudentUser {
  static List<Category> _getSkillSet(Map<String, dynamic> json) {
    var jsonList = json["skillSets"] ?? json["SkillSets"] ?? json["skillsets"] ?? json["Skillsets"];
    return (jsonList as List).mapToList((innerJson) => Category.fromJson(innerJson));
  }

  static List<Language> _getLanguages(Map<String, dynamic> json) {
    var jsonList = json["languages"] ?? json["language"] ?? [];
    return (jsonList as List).mapToList((innerJson) => Language.fromJson(innerJson));
  }

  int id = -1;
  String name = '';
  Category? techStack = Category();
  List<Category> skillSet = [];
  List<String> educations = [];
  List<String> experiences = [];
  List<Language> languages = [];
  File? cv;
  File? transcript;

  StudentUser();

  StudentUser.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    name = json["name"] ?? json["Name"] ?? "",
    techStack = Category.fromJson(json["techStack"] ?? json["TechStack"]),
    skillSet = _getSkillSet(json),
    educations = List<String>.from(json["educations"] ?? json["education"] ?? []),
    experiences = List<String>.from(json["experiences"] ?? json["experience"] ?? []),
    languages = _getLanguages(json);
}
