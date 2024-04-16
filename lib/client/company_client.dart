import 'dart:convert';
import 'package:student_hub_flutter/models.dart';
import 'package:http/http.dart' as http;
import '../client.dart';

Future<Project> createProject(Project project) async {
  _checkLogInState();

  var response = await http.post(
    Uri.parse("$baseUrl/api/project"),
    body: jsonEncode({
      "companyId": user!.company!.id,
      "projectScopeFlag": project.scope,
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

Future<void> scheduleMeeting(Meeting meeting, {
  required int projectId,
  required int receiverId
}) async {
  _checkLogInState();

  var response = await http.post(
    Uri.parse("$baseUrl/api/interview"),
    headers: authJsonHeaders,
    body: jsonEncode({
      "title": meeting.title,
      if (meeting.content.isNotEmpty) "content": meeting.content,
      "startTime": meeting.startTime.toIso8601String(),
      "endTime": meeting.endTime.toIso8601String(),
      "projectId": projectId,
      "senderId": user!.id,
      "receiverId": receiverId,
      "meeting_room_code": meeting.room!.code,
      "meeting_room_id": meeting.room!.userDefinedId
    })
  );

  handleResponse(response);
}

_checkLogInState() {
  if (token.isEmpty || user == null) {
    throw Exception("Hasn't logged in yet");
  }

  if (user!.company == null) {
    throw Exception("User hasn't created a company profle");
  }
}