class MeetingRoom {
  int id = -1;
  String code = "";
  String userDefinedId = "";
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  DateTime? expireTime;

  MeetingRoom({this.code = "", this.userDefinedId = ""}) : createdAt = DateTime.now();

  MeetingRoom.fromJson(Map<String, dynamic> json, {String? name}) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    code = json["meeting_room_code"] ?? json["code"] ?? "",
    userDefinedId = json["meeting_room_id"] ?? "",
    createdAt = DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? ""),
    deletedAt = DateTime.tryParse(json["deletedAt"] ?? ""),
    expireTime = DateTime.tryParse(json["expired_at"] ?? "");

  @override
  bool operator==(Object other) {
    return other is MeetingRoom && id == other.id;
  }

  @override
  int get hashCode => id;
}