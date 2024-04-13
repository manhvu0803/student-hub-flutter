import 'package:student_hub_flutter/models/company_user.dart';
import 'package:student_hub_flutter/models/student_user.dart';

class User {
  int id = -1;
  String fullName = "";
  StudentUser? student;
  CompanyUser? company;

  User();

  User.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    fullName = json["fullname"] ?? json["Fullname"] ?? json["fullName"] ?? json["FullName"]
  {
    try {
      student = StudentUser.fromJson(json["student"] ?? json["Student"]);
    }
    catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }

    try {
      company = CompanyUser.fromJson(json["company"] ?? json["Company"]);
    }
    catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
  }
}