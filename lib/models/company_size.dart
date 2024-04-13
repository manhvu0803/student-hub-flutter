enum CompanySize {
  one(0, "It's just me"),
  small(1, "2 - 9 people"),
  medium(2, "10 - 99 people"),
  large(3, "100 - 1000 people"),
  veryLarge(4, "More than 1000 people");

  final int flag;
  final String description;

  const CompanySize(this.flag, this.description);

  static CompanySize fromFlag(int flag) {
    return switch (flag) {
      0 => one,
      1 => small,
      2 => medium,
      3 => large,
      _ => veryLarge
    };
  }
}