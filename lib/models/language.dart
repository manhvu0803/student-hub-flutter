import 'category.dart';

class Language extends Category {
  String level = "";

  Language();

  Language.fromJson(super.json) :
    level = json["level"] ?? "",
    super.fromJson(name: json["languageName"]);

  @override
  bool operator==(Object other) => other is Language && other.name == name;

  @override
  int get hashCode => name.hashCode;
}