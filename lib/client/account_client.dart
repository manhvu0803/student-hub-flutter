import 'dart:convert';
import 'package:student_hub_flutter/client.dart';
import 'package:http/http.dart' as http;
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models.dart';

String userEmail = "";

Future<User> getUserInfo() async {
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
  return user!;
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
  token = json["result"]?["token"] ?? json["token"] ?? json["result"] ?? json ?? "";
  userEmail = email;

  await Future.wait([
    prefs.setString("token", token),
    prefs.setString("email", userEmail),
    getUserInfo()
  ]);
}

Future<void> logOut() async {
  user = null;
  token = "";
  prefs.setString("token", "");
  checkLogInStatus();

  var response = await http.post(
    Uri.parse("$baseUrl/api/auth/logout"),
    headers: {
      "Authorization": "Bearer $token"
    }
  );

  handleResponse(response);
}

Future<void> resetPassword() async {
  checkLogInStatus();

  var response = await http.put(
    Uri.parse("$baseUrl/api/user/forgotPassword"),
    headers: authJsonHeaders,
  );

  handleResponse(response);
}

Future<void> changePassword(String oldPassword, String newPassword) async {
  checkLogInStatus();

  var response = await http.put(
    Uri.parse("$baseUrl/api/user/changePassword"),
    headers: authJsonHeaders,
    body: jsonEncode({
      "oldPassword": oldPassword,
      "newPassword": newPassword
    })
  );

  handleResponse(response);
}

Future<List<Meeting>> getMeetings() async {
  checkLogInStatus();

  var response = await http.get(
    Uri.parse("$baseUrl/api/interview/user/${user!.id}"),
    headers: authHeaders
  );

  var json = handleResponse(response);
  var list = (json["result"] ?? json) as List;
  var meetings = list.mapToList((innerJson) => Meeting.fromJson(innerJson));
  var now = DateTime.now();

  meetings.sort((a, b) {
    if (a.endTime.compareTo(now) <= 0) {
      return 1;
    }

    if (b.endTime.compareTo(now) <= 0) {
      return -1;
    }

    var aCompare = a.startTime.compareTo(now);
    var bCompare = b.startTime.compareTo(now);

    if (aCompare <= 0 && bCompare >= 0) {
      return -1;
    }

    if (bCompare <= 0 && aCompare >= 0) {
      return 1;
    }

    return a.startTime.compareTo(b.startTime);
  });

  return meetings;
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

bool isLogIn({bool asStudent = false, bool asCompany = false}) {
  try {
    checkLogInStatus(isCompany: asCompany, isStudent: asStudent);
  }
  catch (e) {
    return false;
  }

  return true;
}