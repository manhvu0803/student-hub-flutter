import 'package:http/http.dart' as http;
import 'package:student_hub_flutter/models/category.dart';
import 'client.dart';

Map<int, Category> techStacks = {};
Map<int, Category> skillSets = {};

Future<Map<int, Category>> getTeckStacks() async {
  techStacks = await _getCategories("api/techstack/getAllTechStack");
  return techStacks;
}

Future<Map<int, Category>> getSkillSets() async {
  skillSets = await _getCategories("api/skillset/getAllSkillSet");
  return skillSets;
}

Future<Map<int, Category>> _getCategories(String subUrl) async {
  _checkLogInState();

  var response = await http.get(
    Uri.parse("$baseUrl/$subUrl"),
    headers: {
      "Authorization": "Bearer $token",
    }
  );

  var json = handleResponse(response);
  var container = <int, Category>{};

  parseArrayJson(
    json: json,
    parser: (json) {
      var category = Category.fromJson(json);

      if (category.id != null) {
        container[category.id!] = category;
      }
    }
  );

  return container;
}

_checkLogInState() {
  if (token.isEmpty || user == null) {
    throw Exception("Hasn't logged in yet");
  }

  if (user!.company == null) {
    throw Exception("User hasn't created a student profle");
  }
}
