import 'company_size.dart';

export 'company_size.dart';

class CompanyUser{
  int id = -1;
  String name = '';
  String website = '';
  String description = '';
  CompanySize size = CompanySize.veryLarge;

  CompanyUser();

  CompanyUser.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    name = json["companyName"] ?? json["name"] ?? json["Name"],
    website = json["website"] ?? json["Website"] ?? "",
    description = json["description"] ?? json["Description"] ?? "",
    size = CompanySize.fromFlag(json["size"] ?? json["Size"] ?? -1);
}