import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/proposal.dart';

import 'company_user.dart';
import 'project_scope.dart';
import 'project_status.dart';

export 'project_scope.dart';
export 'project_status.dart';

class Project {
  int id = -1;
  String title = '';
  DateTime createdAt = DateTime.now();
  DateTime? updatedAt;
  DateTime? deletedAt;
  String description = '';
  String companyId = "";
  String companyName = "";
  ProjectScope scope = ProjectScope.short;
  int numberOfStudent = -1;
  int type = -1;
  int proposalCount = -1;
  int hireCount = -1;
  int messageCount = -1;
  bool isFavorite = false;
  List<Proposal> proposals = [];
  CompanyUser? company;
  ProjectStatus status = ProjectStatus.preparing;

  Project();

  Project.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    createdAt = DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? ""),
    deletedAt = DateTime.tryParse(json["deletedAt"] ?? ""),
    description = json["description"] ?? json["desc"],
    companyId = json["companyId"] ?? "",
    companyName = json["companyName"] ?? "",
    scope = ProjectScope.fromFlag(json["projectScopeFlag"] ?? -1),
    title = json["title"] ?? -1,
    numberOfStudent = json["numberOfStudent"] ?? -1,
    type = json["type"] ?? -1,
    proposalCount = json["countProposals"] ?? -1,
    messageCount = json["countMessages"] ?? -1,
    hireCount = json["countHired"] ?? -1,
    isFavorite = json["isFavorite"] ?? false,
    status = ProjectStatus.fromFlag(json["typeFlag"] ?? -1),
    proposals = (json["proposals"] as List? ?? []).mapToList((innerJson) => Proposal.fromJson(innerJson))
  {
    int companyId = int.tryParse(json["companyId"] ?? "-1") ?? -1;

    if (companyId > 0) {
      company = CompanyUser()
        ..id = companyId
        ..name = json["companyName"] ?? "";
    }
  }

  @override
  bool operator==(Object other) {
    return other is Project && id == other.id;
  }

  @override
  int get hashCode => id;
}