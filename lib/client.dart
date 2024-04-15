import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub_flutter/client/student_client.dart';
import 'package:student_hub_flutter/models/user.dart';
import 'client/account_client.dart';

export 'client/account_client.dart';
export 'client/data_client.dart';

const String baseUrl = "https://api.studenthub.dev";

String token = "";
User? user;
late SharedPreferences prefs;

Map<String, String> get authHeaders => {
  "Authorization": "Bearer $token",
};

Map<String, String> get authJsonHeaders => {
  "Content-Type": "application/json",
  "Authorization": "Bearer $token",
};

Future<void> init() async {
  prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token") ?? "";
  userEmail = prefs.getString("email") ?? "";

  if (token.isNotEmpty && userEmail.isNotEmpty) {
    await getUserInfo();
    await Future.wait([
      getSkillSets(),
      getTeckStacks()
    ]);
  }
}

Map<String, dynamic> handleResponse(http.Response response) {
  var json = jsonDecode(response.body) as Map<String, dynamic>;

  if (200 <= response.statusCode && response.statusCode < 300) {
    return json;
  }

  var errorDetails = json["errorDetails"];

  if (errorDetails == null) {
    throw Exception("Unknow HTTP error: ${response.statusCode}");
  }

  if (errorDetails is List) {
    throw Exception(errorDetails[0].toString());
  }

  throw Exception(errorDetails.toString());
}

void parseArrayJson<T, U>({
  required Map<String, dynamic> json,
  required void Function(dynamic) parser,
}) {
  for (var innerJson in json["result"] ?? json) {
    try {
      parser(innerJson);
    }
    catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
  }
}