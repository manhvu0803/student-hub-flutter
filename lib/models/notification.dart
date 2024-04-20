import 'package:student_hub_flutter/models/proposal.dart';
import 'package:student_hub_flutter/models/user.dart';
import 'package:student_hub_flutter/utils.dart';
import 'notification_type.dart';

export 'notification_type.dart';

class Notification {
  int id = -1;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String title = "";
  String content = "";
  String? message;
  User? sender;
  User? receiver;
  Proposal? proposal;
  bool isRead = false;
  NotificationType type = NotificationType.chat;

  Notification() :
    createdAt = DateTime.now();

  Notification.fromJson(Map<String, dynamic> json, {this.sender, this.receiver, this.proposal}) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    createdAt = DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? ""),
    deletedAt = DateTime.tryParse(json["deletedAt"] ?? ""),
    title = json["title"] ?? "",
    content = json["content"] ?? "",
    isRead = int.tryParse(json["notifyFlag"] ?? "0") == 1
  {
    var innerJson = json["sender"];

    if (sender == null && innerJson != null) {
      tryLog(() => sender = User.fromJson(innerJson));
    }

    innerJson = json["receiver"];

    if (receiver == null && innerJson != null) {
      tryLog(() => receiver = User.fromJson(innerJson));
    }

    innerJson = json["proposal"];

    if (proposal == null && innerJson != null) {
      tryLog(() => proposal = Proposal.fromJson(innerJson));
    }
  }

  @override
  bool operator==(Object other) => other is Notification && id == other.id;

  @override
  int get hashCode => id;
}