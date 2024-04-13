void tryLog<T>(T Function() callback) {
  try {
    callback();
  }
  catch (e, stackTrace) {
    print(e);
    print(stackTrace);
  }
}

// For dynamic types
List<U> toList<T, U>(Iterable<T> iterable, U Function(T) builder) {
    var list = <U>[];

    for (var item in iterable) {
      list.add(builder(item));
    }

    return list;
}