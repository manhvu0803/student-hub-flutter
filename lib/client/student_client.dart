import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/category.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/models/student_user.dart';
import 'client.dart';

Map<int, Category> techStacks = {};
Map<int, Category> skillSets = {};

Future<Map<int, Category>> getTeckStacks() async {
  techStacks = await _getCategories("api/techstack/getAllTechStack");
  return techStacks;
}

Future<Map<int, Category>> getSkillSets() async {
  skillSets = await _getCategories("api/skillset/getAllSkillSet");
  return skillSets;
}

Future<Map<int, Category>> _getCategories(String subUrl) async {
  _checkLogInState();

  var response = await http.get(
    Uri.parse("$baseUrl/$subUrl"),
    headers: {
      "Authorization": "Bearer $token",
    }
  );

  var json = handleResponse(response);
  var container = <int, Category>{};

  parseArrayJson(
    json: json,
    parser: (json) {
      var category = Category.fromJson(json);

      if (category.id != null) {
        container[category.id!] = category;
      }
    }
  );

  return container;
}

Future<void> updateProfile(StudentUser newStudent) async {
  _checkLogInState();

  await Future.wait([
    http.put(
      Uri.parse("$baseUrl/api/profile/student/${user!.student!.id}"),
      headers: authJsonHeaders,
      body: jsonEncode({
        "techStackId": newStudent.techStack?.id ?? 0,
        "skillSets": newStudent.skillSet.mapToList((skill) => skill.id)
      })
    ),
    http.put(
      Uri.parse("$baseUrl/api/language/updateByStudentId/${user!.student!.id}"),
      headers: authJsonHeaders,
      body: jsonEncode({
        "languages": newStudent.languages.mapToList((language) => {
          "id": language.id,
          "languageName": language.name,
          "level": language.level
        })
      })
    ),
  ]);

  user!.student = newStudent;
}

Future<List<Project>> searchProject({String? projectTitle, int page = 1, int pageLimit = 5}) async {
  _checkLogInState();
  var urlBuilder = StringBuffer("$baseUrl/api/project?page=$page&perPage=$pageLimit");

  if (projectTitle != null && projectTitle.isNotEmpty) {
    urlBuilder.write("&title=$projectTitle");
  }

  var response = await http.get(Uri.parse(urlBuilder.toString()), headers: authHeaders);
  var json = handleResponse(response);
  var list = json["result"] ?? json["results"] ?? json;
  return (list as List).mapToList((innerJson) => Project.fromJson(innerJson));
}

Future<void> setFavorite(Project project, bool value) async {
  // TODO: Toggle favorite API
}

_checkLogInState() {
  if (token.isEmpty || user == null) {
    throw Exception("Hasn't logged in yet");
  }

  if (user!.company == null) {
    throw Exception("User hasn't created a student profle");
  }
}
