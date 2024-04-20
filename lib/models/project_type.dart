enum ProjectType {
  preparing(0),
  working(1),
  archived(2);

  final int flag;

  const ProjectType(this.flag);

  static ProjectType fromFlag(int flag) {
    return switch (flag) {
      1 => working,
      2 => archived,
      _ => preparing,
    };
  }
}