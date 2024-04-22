extension IterableExtension<T> on Iterable<T> {
  List<U> mapToList<U>(U Function(T item) builder) {
    var list = <U>[];

    for (var item in this) {
      list.add(builder(item));
    }

    return list;
  }
}