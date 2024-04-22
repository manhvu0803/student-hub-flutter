import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/proposal.dart';
import 'company_user.dart';
import 'project_scope.dart';
import 'project_type.dart';
import 'project_status.dart';

export 'project_scope.dart';
export 'project_status.dart';
export 'project_type.dart';

class Project {
  static _getCompanyId(Map<String, dynamic> json) {
    if ((json["companyId"] is String)) {
      return int.tryParse(json["companyId"] ?? "") ?? -1;
    }

    return json["companyId"];
  }

  int id = -1;
  String title = '';
  DateTime createdAt = DateTime.now();
  DateTime? updatedAt;
  DateTime? deletedAt;
  String description = '';
  int companyId = -1;
  String companyName = "";
  ProjectScope scope = ProjectScope.short;
  int numberOfStudent = -1;
  int proposalCount = -1;
  int hireCount = -1;
  int messageCount = -1;
  bool isFavorite = false;
  List<Proposal> proposals = [];
  CompanyUser? company;
  ProjectStatus status = ProjectStatus.working;
  ProjectType type = ProjectType.preparing;

  Project();

  Project.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    createdAt = DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? ""),
    deletedAt = DateTime.tryParse(json["deletedAt"] ?? ""),
    description = json["description"] ?? json["desc"],
    companyId = _getCompanyId(json),
    companyName = json["companyName"] ?? "",
    scope = ProjectScope.fromFlag(json["projectScopeFlag"] ?? -1),
    title = json["title"] ?? -1,
    numberOfStudent = json["numberOfStudents"] ?? json["numberOfStudent"] ?? -1,
    type = ProjectType.fromFlag(json["typeFlag"] ?? json["type"] ?? json["projectType"] ?? -1),
    proposalCount = json["countProposals"] ?? -1,
    messageCount = json["countMessages"] ?? -1,
    hireCount = json["countHired"] ?? -1,
    isFavorite = json["isFavorite"] ?? false,
    status = ProjectStatus.fromFlag(json["status"] ?? json["statusFlag"] ?? -1),
    proposals = (json["proposals"] as List? ?? []).mapToList((innerJson) => Proposal.fromJson(innerJson))
  {
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

  Project copyWith() {
    return Project()
      ..id = id
      ..updatedAt = updatedAt
      ..createdAt = createdAt
      ..deletedAt =deletedAt
      ..description = description
      ..companyId = companyId
      ..companyName = companyName
      ..scope = scope
      ..title = title
      ..numberOfStudent =numberOfStudent
      ..type = type
      ..proposalCount = proposalCount
      ..messageCount = messageCount
      ..hireCount = hireCount
      ..isFavorite = isFavorite
      ..status = status
      ..proposals = proposals;
  }
}