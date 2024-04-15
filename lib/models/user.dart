import 'package:student_hub_flutter/models/company_user.dart';
import 'package:student_hub_flutter/models/student_user.dart';
import 'package:student_hub_flutter/utils.dart';

export 'user_role.dart';

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
    tryLog(() => student = StudentUser.fromJson(json["student"] ?? json["Student"]));
    tryLog(() => company = CompanyUser.fromJson(json["company"] ?? json["Company"]));
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is User && id == other.id;
}