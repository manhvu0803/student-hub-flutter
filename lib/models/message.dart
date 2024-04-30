import 'package:student_hub_flutter/utils.dart';
import 'company_user.dart';
import 'meeting.dart';
import 'notification.dart';
import 'project.dart';
import 'student_user.dart';
import 'user.dart';

class Message {
  static Project _getProject(Map<String, dynamic> json) {
    if (json["project"] != null) {
      return Project.fromJson(json["project"]);
    }

    return Project();
  }

  int? id;
  String content = "";
  DateTime createdAt;
  User sender;
  User receiver;
  Meeting? meeting;
  Project project;
  Notification? notification;

  Message() :
    createdAt = DateTime.now(),
    sender = User(),
    receiver = User(),
    project = Project();

  Message.fromJson(Map<String, dynamic> json, {
    User? sender,
    User? receiver,
    Project? project,
    this.notification,
    this.meeting
  }) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    content = json["content"] ?? "",
    sender = sender ?? User.fromJson(json["sender"], student: StudentUser(), company: CompanyUser()),
    receiver = receiver ?? User.fromJson(json["receiver"], student: StudentUser(), company: CompanyUser()),
    createdAt = DateTime.tryParse(json["createdAt"] ?? "")?.toLocal() ?? DateTime.now(),
    project = project ?? _getProject(json)
  {
    var innerJson = json["notification"] ?? json["notifications"];
    if (notification == null && innerJson != null) {
      tryLog(() => notification = Notification.fromJson(innerJson));
    }

    innerJson = json["interview"] ?? json["meeting"];
    if (meeting == null && innerJson != null) {
      tryLog(() => meeting = Meeting.fromJson(innerJson));
    }
  }

  @override
  bool operator==(Object other) => other is Message && id == other.id;

  @override
  int get hashCode => id ?? -1;

  User getOther(User user) => (sender.id == user.id) ? receiver : sender;
}