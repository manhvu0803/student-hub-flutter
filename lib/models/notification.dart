class Notification {
  int id = -1;

  Notification();

  Notification.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? json["Id"] ?? json["ID"];

  @override
  bool operator==(Object other) => other is Notification && id == other.id;

  @override
  int get hashCode => id;
}