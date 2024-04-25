extension IterableExtension<T> on Iterable<T> {
  List<U> mapToList<U>(U Function(T item) builder, {
    bool Function(T item)? beforeFilter,
    bool Function(U item)? afterFilter
  }) {
    var list = <U>[];

    for (var item in this) {
      if (beforeFilter?.call(item) ?? true) {
        var result = builder(item);

        if (afterFilter?.call(result) ?? true) {
          list.add(result);
        }
      }
    }

    return list;
  }
}