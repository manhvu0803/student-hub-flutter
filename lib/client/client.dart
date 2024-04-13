import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './account_client.dart';
import 'package:student_hub_flutter/models/user.dart';

export './account_client.dart';
export './company_client.dart';

const String baseUrl = "https://api.studenthub.dev";

String token = "";
User? user;
late final SharedPreferences prefs;

Future<void> init() async {
  prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token") ?? "";

  if (token.isNotEmpty) {
    await getUserInfo();
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