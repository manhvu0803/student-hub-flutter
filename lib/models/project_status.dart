enum ProjectStatus {
  preparing(0),
  working(1),
  achieved(2);

  final int flag;

  const ProjectStatus(this.flag);

  static ProjectStatus fromFlag(int flag) {
    return switch (flag) {
      0 => preparing,
      1 => working,
      _ => achieved,
    };
  }
}