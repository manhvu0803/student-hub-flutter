import 'package:http/http.dart' as http;
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models.dart';
import '../client.dart';

Future<Project> getProject(int projectId) async {
  checkLogInStatus();

  var response = await http.get(
    Uri.parse("$baseUrl/api/project/$projectId"),
    headers: authHeaders
  );

  var json = handleResponse(response);
  return Project.fromJson(json["result"] ?? json);
}

Future<List<Proposal>> getProposals(int projectId, {ProposalStatus? statusFilter}) async {
  checkLogInStatus();

  var buffer = StringBuffer("$baseUrl/api/proposal/getByProjectId/$projectId?");

  if (statusFilter != null) {
    buffer.write("statusFlag=");
    buffer.write(statusFilter.flag);
  }

  var response = await http.get(
    Uri.parse(buffer.toString()),
    headers: authHeaders
  );

  var json = handleResponse(response);
  var list = (json["result"]?["items"] ?? json["result"] ?? json) as List;
  return list.mapToList((innerJson) => Proposal.fromJson(innerJson));
}