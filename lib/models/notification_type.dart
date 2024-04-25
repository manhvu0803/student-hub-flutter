enum NotificationType {
  offer(0),
  interview(1),
  submitted(2),
  chat(3),
  hired(4),
  other(-1);

  static NotificationType fromFlag(int flag) {
    return switch (flag) {
      0 => offer,
      1 => interview,
      2 => submitted,
      3 => chat,
      4 => hired,
      _ => other
    };
  }

  final int flag;

  const NotificationType(this.flag);
}