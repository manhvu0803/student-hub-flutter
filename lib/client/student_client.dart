import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models.dart';
import '../client.dart';

Map<int, Category> techStacks = {};
Map<int, Category> skillSets = {};

Future<Map<int, Category>> getTeckStacks() async {
  return await _getCategories("api/techstack/getAllTechStack");
}

Future<Map<int, Category>> getSkillSets() async {
  return await _getCategories("api/skillset/getAllSkillSet");
}

Future<Map<int, Category>> _getCategories(String subUrl) async {
  checkLogInStatus(isStudent: true);

  var response = await http.get(
    Uri.parse("$baseUrl/$subUrl"),
    headers: authHeaders
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
  checkLogInStatus(isStudent: true);

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
  checkLogInStatus(isStudent: true);
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
  checkLogInStatus(isStudent: true);
}

Future<Proposal> applyForProject({
  required int projectId,
  required String proposal
}) async {
  checkLogInStatus(isStudent: true);

  var response = await http.post(
    Uri.parse("$baseUrl/api/proposal"),
    headers: authJsonHeaders,
    body: jsonEncode({
      "projectId": projectId,
      "studentId": user!.student!.id,
      "coverLetter": proposal
    })
  );

  var json = handleResponse(response);
  return Proposal.fromJson(json["result"] ?? json, student: user!.student!);
}

Future<void> patchProposal(Proposal proposal) async {
  checkLogInStatus();

  await rawPatchProposal(
    proposalId: proposal.id,
    body: {
      "coverLetter": proposal.content,
      "statusFlag": proposal.status.flag,
      "disableFlag": proposal.isEnabled ? 0 : 1
    }
  );
}


Future<Map<String, dynamic>> rawPatchProposal({required int proposalId, required Map<String, dynamic> body}) async {
  var response = await http.patch(
    Uri.parse("$baseUrl/api/proposal/$proposalId"),
    headers: authJsonHeaders,
    body: jsonEncode(body)
  );

  return handleResponse(response);
}