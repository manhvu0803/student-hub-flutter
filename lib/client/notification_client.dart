import 'package:http/http.dart' as http;
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models.dart';
import '../client.dart';

Future<List<Notification>> getNotifications() async {
  checkLogInStatus();

  var response = await http.get(
    Uri.parse("$baseUrl/api/notification/getByReceiverId/${user!.id}"),
    headers: authHeaders
  );

  var json = handleResponse(response);
  var list = (json["result"] ?? json) as List;
  return list.mapToList((p0) => Notification.fromJson(p0));
}

Future<void> readNotification(int notificationId) async {
  checkLogInStatus();

  var response = await http.patch(
    Uri.parse("$baseUrl/api/notification/readNoti/$notificationId"),
    headers: authHeaders
  );

  handleResponse(response);
}