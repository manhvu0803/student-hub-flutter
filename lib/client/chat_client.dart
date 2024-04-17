import 'dart:convert';

import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/message.dart';
import '../client.dart';
import 'package:http/http.dart' as http;

// Get all messages represent a unique chat thread
Future<List<Message>> getAllChat() async {
  return await getMessages(subUrl: "api/message/");
}

Future<List<Message>> getChatMessages({
  required int projectId,
  required int recipientId
}) async {
  return await getMessages(subUrl: "api/message/$projectId/user/$recipientId");
}

Future<List<Message>> getMessages({required String subUrl}) async {
  _checkLogInState();

  var response = await http.get(
    Uri.parse("$baseUrl/$subUrl"),
    headers: authHeaders
  );

  var json = handleResponse(response);
  var list = (json["result"] ?? json["results"] ?? json) as List;
  return list.mapToList((innerJson) => Message.fromJson(innerJson));
}

Future<Message?> sendMessage({
  required int projectId,
  required int recipientId,
  required String content,
  int messageFlag = 0,
}) async {
  _checkLogInState();

  var response = await http.post(
    Uri.parse("$baseUrl/api/message/sendMessage"),
    headers: authJsonHeaders,
    body: jsonEncode({
      "projectId": projectId,
      "receiverId": recipientId,
      "senderId": user!.id,
      "content": content,
      "messageFlag": messageFlag
    })
  );

  var json = handleResponse(response);
  var innerJson = json["result"] ?? json["results"] ?? json;

  if (innerJson == null
    || (innerJson is Iterable && innerJson.isEmpty)
    || (innerJson is Map && innerJson.isEmpty)) {
    return null;
  }

  return Message.fromJson(innerJson);
}

void _checkLogInState() {
  if (token.isEmpty || user == null) {
    throw Exception("Hasn't logged in yet");
  }
}