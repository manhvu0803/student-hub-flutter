import 'dart:convert';
import 'package:student_hub_flutter/models/company_user.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:http/http.dart' as http;
import 'client.dart';

Future<Project> createProject(Project project) async {
  _checkLogInState();

  var response = await http.post(
    Uri.parse("$baseUrl/api/project"),
    body: jsonEncode({
      "companyId": user!.company!.id,
      "projectScopeFlag": project.projectScope,
      "title": project.title,
      "description": project.description,
      "numberOfStudents": project.numberOfStudent
    }),
    headers: authJsonHeaders
  );

  var json = handleResponse(response);
  return Project.fromJson(json["result"]);
}

Future<List<Project>> getProjects() async {
  _checkLogInState();

  var response = await http.get(
    Uri.parse("$baseUrl/api/project/company/${user!.company!.id}"),
    headers: {
      "Authorization": "Bearer $token",
    }
  );

  var json = handleResponse(response);
  var projects = <Project>[];

  parseArrayJson(
    json: json,
    parser: (json) => projects.add(Project.fromJson(json))
  );

  return projects;
}

Future<void> updateProfile(CompanyUser company) async {
  _checkLogInState();

  var response = await http.put(
    Uri.parse("$baseUrl/api/profile/company/${user!.company!.id}"),
    headers: authJsonHeaders,
    body: jsonEncode({
      "companyName": company.name,
      "size": company.size.flag,
      "website": company.website,
      "description": company.description
    })
  );

  handleResponse(response);
  user!.company = company;
}

_checkLogInState() {
  if (token.isEmpty || user == null) {
    throw Exception("Hasn't logged in yet");
  }

  if (user!.company == null) {
    throw Exception("User hasn't created a company profle");
  }
}