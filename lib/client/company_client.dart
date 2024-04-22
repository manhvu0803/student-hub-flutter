import 'dart:convert';
import 'dart:math';
import 'package:student_hub_flutter/client/student_client.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:http/http.dart' as http;
import '../client.dart';

Future<Project> createProject(Project project) async {
  checkLogInStatus(isCompany: true);

  var response = await http.post(
    Uri.parse("$baseUrl/api/project"),
    body: jsonEncode({
      "companyId": user!.company!.id,
      "projectScopeFlag": project.scope.flag,
      "title": project.title,
      "description": project.description,
      "numberOfStudents": project.numberOfStudent
    }),
    headers: authJsonHeaders
  );

  var json = handleResponse(response);
  return Project.fromJson(json["result"] ?? json);
}

Future<List<Project>> getProjects() async {
  checkLogInStatus(isCompany: true);

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
  checkLogInStatus(isCompany: true);

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
  checkLogInStatus(isCompany: true);

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

Future<void> hireStudent(int proposalId) async {
  checkLogInStatus(isCompany: true);
  await rawPatchProposal(
    proposalId: proposalId,
    body: {
      "statusFlag": ProposalStatus.hired.flag
    }
  );
}

Future<void> deleteProject(int projectId) async {
  checkLogInStatus(isCompany: true);

  var response = await http.delete(
    Uri.parse("$baseUrl/api/project/$projectId"),
    headers: authHeaders
  );

  handleResponse(response);
}

Future<void> updateProject(Project project) async {
  checkLogInStatus(isCompany: true);


  var response = await http.patch(
    Uri.parse("$baseUrl/api/project/${project.id}"),
    headers: authJsonHeaders,
    body: jsonEncode({
      "projectScopeFlag": project.scope.flag,
      "title": project.title,
      "description": project.description,
      "numberOfStudents": max(project.numberOfStudent, 0),
      "typeFlag": project.type.flag,
      "status": project.status.flag
    })
  );

  handleResponse(response);
}