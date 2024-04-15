enum ProjectScope {
  short(0, "Less than 1 month"),
  medium(1, "1 - 3 months"),
  long(2, "3 - 6 months"),
  veryLong(3, "More than 6 months");

  final int flag;
  final String description;

  const ProjectScope(this.flag, this.description);

  static ProjectScope fromFlag(int flag) {
    return switch (flag) {
      0 => short,
      1 => medium,
      2 => long,
      _ => veryLong
    };
  }
}