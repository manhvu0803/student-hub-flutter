import 'dart:io';

import 'package:student_hub_flutter/models/education.dart';
import 'package:student_hub_flutter/models/project.dart';

class StudentUser {
  String name = '';
  String techStack = '';
  List<String> skillset = List.empty();
  List<Education> education = List.empty();
  List<Project> projects = List.empty();
  late File cv;
  late File transcript;

  
}
