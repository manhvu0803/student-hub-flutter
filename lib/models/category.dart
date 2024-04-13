class Category {
  int? id;
  String name = "";
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Category() : createdAt = DateTime.now();

  Category.fromJson(Map<String, dynamic> json, {String? name}) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    name = name ?? json["name"] ?? json["Name"],
    createdAt = DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? ""),
    deletedAt = DateTime.tryParse(json["deletedAt"] ?? "");

  @override
  bool operator==(Object other) {
    return other is Category && id == other.id;
  }

  @override
  int get hashCode => id ?? -1;
}