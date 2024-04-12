import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = "https://api.studenthub.dev";

String? token;

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

  var json = _handleResponse(response);
  token = json["result"]["token"];
}

Future<void> signUp(String email, String password, String fullName, bool isStudent) async {
  var response = await http.post(
    Uri.parse("$baseUrl/api/auth/sign-up"),
    body: jsonEncode({
      "email": email,
      "password": password,
      "fullname": fullName,
      "role": isStudent ? 0 : 1
    }),
    headers: {
      "Content-Type": "application/json"
    }
  );

  _handleResponse(response);
}

Future<void> logOut() async {
  if (token == null) {
    throw Exception("Hasn't logged in yet");
  }

  var response = await http.post(
    Uri.parse("$baseUrl/api/auth/logout"),
    headers: {
      "Authorization": "Basic $token"
    }
  );

  _handleResponse(response);
}

Map<String, dynamic> _handleResponse(http.Response response) {
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