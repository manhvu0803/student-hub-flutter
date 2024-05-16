import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models.dart';
import '../client.dart';

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
  checkLogInStatus();

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
  checkLogInStatus();
  var requester = (user!.student == null || user!.student!.id < 0) ? http.post : http.put;
  var id = (user!.student == null || user!.student!.id < 0) ? "" : "/${user!.student!.id}";

  var results = await Future.wait([
    requester(
      Uri.parse("$baseUrl/api/profile/student$id"),
      headers: authJsonHeaders,
      body: jsonEncode({
        "techStackId": newStudent.techStack?.id ?? 0,
        "skillSets": newStudent.skillSet.mapToList((skill) => skill.id)
      })
    ),

    if (user!.student != null) http.put(
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

    if (user!.student != null) http.put(
      Uri.parse("$baseUrl/api/education/updateByStudentId/${user!.student!.id}"),
      headers: authJsonHeaders,
      body: jsonEncode({
        "education": newStudent.educations.mapToList((education) => {
          "id": education.id,
          "schoolName": education.schoolName,
          "startYear": education.startYear,
          "endYear": education.endYear
        })
      })
    ),

    if (user!.student != null) http.put(
      Uri.parse("$baseUrl/api/experience/updateByStudentId/${user!.student!.id}"),
      headers: authJsonHeaders,
      body: jsonEncode({
        "experience": newStudent.experiences.mapToList((experience) => {
          "id": experience.id,
          "title": experience.title,
          "description": experience.description,
          "startMonth": experience.startTime.toMonthString(seperator: "-"),
          "endMonth": experience.endTime.toMonthString(seperator: "-"),
          "skillSets": experience.skillSet.mapToList(
            (skill) => skill.id,
            afterFilter: (id) => id != null && id > 0
          )
        })
      })
    ),
  ]);

  var json = handleResponse(results[0]);

  if (user!.student == null) {
    var responseStudent = CompanyUser.fromJson(json["result"] ?? json);
    newStudent.id = responseStudent.id;
  }

  user!.student = newStudent;
}

Future<List<Project>> searchProject({
  String? projectTitle,
  int page = 1,
  int pageLimit = 5,
  int? numberOfStudents,
  ProjectScope? scope
}) async {
  checkLogInStatus(isStudent: true);

  var urlBuilder = StringBuffer("/api/project?page=$page&perPage=$pageLimit");

  if (projectTitle != null && projectTitle.isNotEmpty) {
    urlBuilder.write("&title=$projectTitle");
  }

  if ((numberOfStudents ?? -1) > 0) {
    urlBuilder.write("&numberOfStudents=$numberOfStudents");
  }

  if (scope != null) {
    urlBuilder.write("&projectScopeFlag=${scope.flag}");
  }

  return _getAndParseProjects(urlBuilder.toString());
}

Future<List<Project>> getProjects({required ProjectType projectType}) async {
  checkLogInStatus(isStudent: true);
  return _getAndParseProjects("/api/project/student/${user!.student!.id}?typeFlag=${projectType.flag}");
}

Future<List<Project>> getFavoriteProjects() async {
  checkLogInStatus(isStudent: true);
  return _getAndParseProjects(
    "/api/favoriteProject/${user!.student!.id}",
    makeFavorite: true
  );
}

Future<List<Project>> _getAndParseProjects(String subUrl, {bool makeFavorite = false}) async {
  var response = await http.get(
    Uri.parse("$baseUrl$subUrl"),
    headers: authHeaders
  );

  var json = handleResponse(response);
  var list = (json["result"] ?? json) as List;
  return list.mapToList((item) {
    var project = Project.fromJson(item["project"] ?? item);
    project.isFavorite = makeFavorite;
    return project;
});
}

Future<void> setFavorite(int projectId, bool isFavorite) async {
  checkLogInStatus(isStudent: true);

  var response = await http.patch(
    Uri.parse("$baseUrl/api/favoriteProject/${user!.student!.id}"),
    headers: authJsonHeaders,
    body: jsonEncode({
      "projectId": projectId,
      "disableFlag": isFavorite ? 0 : 1
    })
  );

  handleResponse(response);
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
  checkLogInStatus(isStudent: true);

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