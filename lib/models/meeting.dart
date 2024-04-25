import 'meeting_room.dart';

export 'meeting_room.dart';

class Meeting {
  int id = -1;
  String title = "";
  String content = "";
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  DateTime startTime;
  DateTime endTime;
  bool isEnabled = true;
  MeetingRoom? room;

  Meeting({
    this.title = "",
    this.content = "",
    this.room,
    required this.startTime,
    required this.endTime
  }) : createdAt = DateTime.now();

  Meeting.fromJson(Map<String, dynamic> json, {String? name}) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    title = json["title"] ?? "",
    content = json["content"] ?? "",
    createdAt = DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? ""),
    deletedAt = DateTime.tryParse(json["deletedAt"] ?? ""),
    startTime = DateTime.parse(json["startTime"]),
    endTime = DateTime.parse(json["endTime"]),
    isEnabled = json["disableFlag"] == 0,
    room = (json["meetingRoom"] != null) ? MeetingRoom.fromJson(json["meetingRoom"]) : null;

  @override
  bool operator==(Object other) {
    return other is Meeting && id == other.id;
  }

  @override
  int get hashCode => id;
}