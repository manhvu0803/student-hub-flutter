import 'dart:convert';
import 'package:student_hub_flutter/client.dart';
import 'package:http/http.dart' as http;
import 'package:student_hub_flutter/models/user.dart';

String userEmail = "";

Future<void> getUserInfo() async {
  if (token.isEmpty) {
    throw Exception("Hasn't logged in yet");
  }

  var response = await http.get(
    Uri.parse("$baseUrl/api/auth/me"),
    headers: {
      "Authorization": "Bearer $token"
    }
  );

  var json = handleResponse(response);
  user = User.fromJson(json["result"] ?? json);
}

Future<void> signUp(String email, String password, String fullName, bool isStudent) async {
  var response = await http.post(
    Uri.parse("$baseUrl/api/auth/sign-up"),
    body: jsonEncode({
      "email": email,
      "password": password,
      "fullname": fullName,
      "role": isStudent ? UserRole.student.flag : UserRole.company.flag
    }),
    headers: {
      "Content-Type": "application/json"
    }
  );

  handleResponse(response);
}

Future<void> signIn(String email, String password) async {
  var response = await http.post(
    Uri.parse("$baseUrl/api/auth/sign-in"),
    body: jsonEncode({
      "email": email,
      "password": password
    }),
    headers: {
      "Content-Type": "application/json"
    }
  );

  var json = handleResponse(response);
  token = json["result"]?["token"] ?? json["token"] ?? json ?? "";

  userEmail = email;

  await Future.wait([
    prefs.setString("token", token),
    prefs.setString("email", userEmail),
    getUserInfo()
  ]);
}

Future<void> logOut() async {
  if (token.isEmpty) {
    throw Exception("Hasn't logged in yet");
  }

  var response = await http.post(
    Uri.parse("$baseUrl/api/auth/logout"),
    headers: {
      "Authorization": "Bearer $token"
    }
  );

  handleResponse(response);
}

void checkLogInStatus({bool isStudent = false, bool isCompany = false}) {
  if (token.isEmpty || user == null) {
    throw Exception("Hasn't logged in yet");
  }

  if (isStudent && (user!.student == null || user!.student!.id < 0)) {
    throw Exception("User hasn't created a student profle");
  }

  if (isCompany && (user!.company == null || user!.company!.id < 0)) {
    throw Exception("User hasn't created a company profle");
  }
}