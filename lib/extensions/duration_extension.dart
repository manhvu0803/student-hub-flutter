extension DurationExtension on Duration {
  String toShortString() {
    if (inDays < 1) {
      return "$inHours hour${(inHours < 2) ? "" : "s"}";
    }

    return "$inDays day${(inDays < 2) ? "" : "s"}";
  }
}