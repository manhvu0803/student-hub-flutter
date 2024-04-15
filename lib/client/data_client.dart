import 'package:http/http.dart' as http;
import 'package:student_hub_flutter/models/project.dart';
import '../client.dart';

Future<Project> getProject(int projectId) async {
  _checkLogInState();

  var response = await http.get(
    Uri.parse("$baseUrl/api/project/$projectId"),
    headers: authHeaders
  );

  var json = handleResponse(response);
  return Project.fromJson(json["result"] ?? json);
}


void _checkLogInState() {
  if (token.isEmpty || user == null) {
    throw Exception("Hasn't logged in yet");
  }
}
