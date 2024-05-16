import 'dart:io';
import 'package:student_hub_flutter/models/education.dart';
import 'package:student_hub_flutter/models/experience.dart';
import 'package:student_hub_flutter/models/language.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'category.dart';

class StudentUser {
  static List<Category> _getSkillSet(Map<String, dynamic> json) {
    var jsonList = json["skillSets"] ?? json["SkillSets"] ?? json["skillsets"] ?? json["Skillsets"] ?? [];
    return (jsonList as List).mapToList((innerJson) => Category.fromJson(innerJson));
  }

  static List<Language> _getLanguages(Map<String, dynamic> json) {
    var jsonList = json["languages"] ?? json["language"] ?? [];
    return (jsonList as List).mapToList((innerJson) => Language.fromJson(innerJson));
  }

  static List<Education> _getEducations(Map<String, dynamic> json) {
    var list = json["educations"] ?? json["education"] ?? [];
    return (list as List).mapToList((innerJson) => Education.fromJson(innerJson));
  }

  static List<Experience> _getExperiences(Map<String, dynamic> json) {
    var list = json["experiences"] ?? json["experience"] ?? [];
    return (list as List).mapToList((innerJson) => Experience.fromJson(innerJson));
  }

  int id = -1;
  int userId = -1;
  String name = '';
  Category? techStack;
  List<Category> skillSet = [];
  List<Education> educations = [];
  List<Experience> experiences = [];
  List<Language> languages = [];
  File? cv;
  File? transcript;

  StudentUser();

  StudentUser.fromJson(Map<String, dynamic> json, {String? name}) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    userId = json["userId"] ?? json["userid"] ?? json["userID"] ?? -1,
    name = name ?? json["name"] ?? json["Name"] ?? json["fullname"] ?? json["user"]?["fullname"] ?? "",
    techStack = Category.fromJson(json["techStack"] ?? json["TechStack"]),
    skillSet = _getSkillSet(json),
    educations = _getEducations(json),
    experiences = _getExperiences(json),
    languages = _getLanguages(json);

  String get educationString => educations.lastOrNull?.name ?? "No experience";
}
