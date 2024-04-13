class Category {
  int id = -1;
  String name = "";
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Category() : createdAt = DateTime.now();

  Category.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    name = json["name"] ?? json["Name"],
    createdAt = DateTime.tryParse(json["createdAt"]) ?? DateTime.now(),
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? ""),
    deletedAt = DateTime.tryParse(json["deletedAt"] ?? "");
}