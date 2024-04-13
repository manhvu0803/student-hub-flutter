class CompanyUser{
  int id = -1;
  String name = '';
  String website = '';
  String description = '';
  int size = 0;

  CompanyUser();

  CompanyUser.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? json["Id"] ?? json["ID"],
    name = json["companyName"] ?? json["name"] ?? json["Name"],
    website = json["website"] ?? json["Website"] ?? "",
    description = json["description"] ?? json["Description"] ?? "",
    size = json["size"] ?? json["Size"];
}