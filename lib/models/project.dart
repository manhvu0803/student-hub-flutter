class Project {
  String name = '';
  DateTime timeStart = DateTime.now();
  DateTime timeEnd = DateTime.now();
  String desc = '';
  List<String> skillset = List.empty();

  Project(this.name, this.timeStart, this.timeEnd, this.desc, this.skillset);
}
