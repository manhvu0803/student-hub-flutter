import 'interview.dart';
import 'notification.dart';
import 'project.dart';
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
  Interview? interview;
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
    this.notification
  }) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    content = json["content"] ?? "",
    sender = sender ?? User.fromJson(json["sender"]),
    receiver = receiver ?? User.fromJson(json["receiver"]),
    createdAt = DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    project = project ?? _getProject(json)
  {
    if (notification == null && json["notification"] != null) {
      notification = Notification.fromJson(json["notification"] ?? json["notifications"]);
    }
  }

  @override
  bool operator==(Object other) => other is Message && id == other.id;

  @override
  int get hashCode => id ?? -1;

  User getOther(User user) => (sender.id == user.id) ? receiver : sender;
}