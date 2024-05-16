import 'models.dart';

final Set<void Function()> _callbacks = {};

void init(User user) {
  _isStudent = user.company == null;
}

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

bool _isStudent = false;

bool get isStudent => _isStudent;

set isStudent(bool value) {
  _isStudent = value;
  _notifiyListeners();
}

void setProfileType({required bool isStudent}) {
  _isStudent = isStudent;
}