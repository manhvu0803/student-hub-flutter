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

  User.fromJson(Map<String, dynamic> json, {this.student, this.company}) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    fullName = json["fullname"] ?? json["Fullname"] ?? json["fullName"] ?? json["FullName"]
  {
    var innerJson = json["student"] ?? json["Student"];
    if (student == null && innerJson != null) {
      tryLog(() => student = StudentUser.fromJson(innerJson));
    }

    innerJson = json["company"] ?? json["Company"];
    if (company == null) {
      tryLog(() => company = CompanyUser.fromJson(innerJson));
    }
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is User && id == other.id;
}