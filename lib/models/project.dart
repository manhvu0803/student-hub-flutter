class Project {
  int id = -1;
  String title = '';
  DateTime createdAt = DateTime.now();
  DateTime? updatedAt;
  DateTime? deletedAt;
  String description = '';
  String companyId = "";
  String companyName = "";
  int projectScope = -1;
  int numberOfStudent = -1;
  int type = -1;
  int proposalCount = -1;
  bool isFavorite = false;

  Project();

  Project.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    createdAt = json["createdAt"] ?? DateTime.now(),
    updatedAt = json["updatedAt"],
    deletedAt = json["deletedAt"],
    description = json["description"] ?? json["desc"],
    companyId = json["companyId"],
    companyName = json["companyName"],
    projectScope = json["projectScopeFlag"],
    title = json["title"],
    numberOfStudent = json["numberOfStudent"],
    type = json["type"],
    proposalCount = json["countProposals"],
    isFavorite = json["isFavorite"] ?? false;
}