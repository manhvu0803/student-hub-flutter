extension StringExtension on String {
  String get uppercaseFirstLetter {
    if (isEmpty) {
      return this;
    }

    return "${this[0].toUpperCase()}${substring(1)}";;
  }
}