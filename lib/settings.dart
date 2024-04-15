final Set<void Function()> _callbacks = {};

void addChangeListener(void Function() callback) {
  _callbacks.add(callback);
}

void removeListener(void Function() callback) {
  _callbacks.remove(callback);
}

void _notifiyListeners() {
  for (var callback in _callbacks) {
    callback();
  }
}

bool _isDarkMode = true;

bool get isDarkMode => _isDarkMode;
set isDarkMode(bool value) {
  _isDarkMode = value;
  _notifiyListeners();
}
