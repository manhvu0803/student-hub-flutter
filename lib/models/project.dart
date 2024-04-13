import 'project_scope.dart';

export 'project_scope.dart';

class Project {
  int id = -1;
  String title = '';
  DateTime createdAt = DateTime.now();
  DateTime? updatedAt;
  DateTime? deletedAt;
  String description = '';
  String companyId = "";
  String companyName = "";
  ProjectScope projectScope = ProjectScope.short;
  int numberOfStudent = -1;
  int type = -1;
  int proposalCount = -1;
  bool isFavorite = false;

  Project();

  Project.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    createdAt = DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? ""),
    deletedAt = DateTime.tryParse(json["deletedAt"] ?? ""),
    description = json["description"] ?? json["desc"],
    companyId = json["companyId"] ?? "",
    companyName = json["companyName"] ?? "",
    projectScope = ProjectScope.fromFlag(json["projectScopeFlag"] ?? -1),
    title = json["title"] ?? -1,
    numberOfStudent = json["numberOfStudent"] ?? -1,
    type = json["type"] ?? -1,
    proposalCount = json["countProposals"] ?? -1,
    isFavorite = json["isFavorite"] ?? false;
}