extension IterableExtension<T> on Iterable<T> {
  List<U> mapToList<U>(U Function(T item) builder, {bool Function(T item)? filter}) {
    var list = <U>[];

    for (var item in this) {
      if (filter?.call(item) ?? true) {
        list.add(builder(item));
      }
    }

    return list;
  }
}