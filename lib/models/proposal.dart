import 'package:student_hub_flutter/utils.dart';
import 'project.dart';
import 'proposal_status.dart';
import 'student_user.dart';

export 'proposal_status.dart';

class Proposal {
  int id = -1;
  DateTime createdAt = DateTime.now();
  DateTime? updatedAt;
  DateTime? deletedAt;
  int projectId = -1;
  Project? project;
  int studentId = -1;
  StudentUser? student;
  String content = "";
  bool isEnabled = false;
  ProposalStatus status = ProposalStatus.waiting;

  Proposal({this.project, this.student});

  Proposal.fromJson(Map<String, dynamic> json, {this.project, this.student}) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    createdAt = DateTime.tryParse(json["createdAt"] ?? "")?.toLocal() ?? DateTime.now(),
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? "")?.toLocal(),
    deletedAt = DateTime.tryParse(json["deletedAt"] ?? "")?.toLocal(),
    projectId = project?.id ?? json["projectId"],
    studentId = student?.id ?? json["studentId"],
    content = json["coverLetter"] ?? ""
  {
    var innerJson = json["student"];
    if (student == null && innerJson != null) {
      tryLog(() => student = StudentUser.fromJson(innerJson));
    }
  }
}