enum ProjectStatus {
  working(0),
  successful(1),
  failed(2);

  final int flag;

  const ProjectStatus(this.flag);

  static ProjectStatus fromFlag(int flag) {
    return switch (flag) {
      0 => working,
      1 => successful,
      _ => failed,
    };
  }
}