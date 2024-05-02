import 'package:fit_rep/themes.dart';
import 'package:flutter/material.dart';

class SettingsManager extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isNotificationEnabled = true;
  int _height = 180;
  int _weight = 70;
  int _notificationFrequency = 0;
  ThemeData _mainTheme = FitRepTheme.light();

  bool get isDarkMode => _isDarkMode;
  bool get isNotificationEnabled => _isNotificationEnabled;
  int get height => _height;
  int get weight => _weight;
  int get notificationFrequency => _notificationFrequency;
  ThemeData get theme => _mainTheme;

  void toggleDarkMode() {
    _isDarkMode = !isDarkMode;
    _mainTheme = isDarkMode ? FitRepTheme.dark() : FitRepTheme.light();
    notifyListeners();
  }

  void toggleNotification() {
    _isNotificationEnabled = !isNotificationEnabled;
    notifyListeners();
  }

  void setHeight(int height) {
    _height = height;
    notifyListeners();
  }

  void setWeight(int weight) {
    _weight = weight;
    notifyListeners();
  }

  void setNotificationFrequency(int frequency) {
    _notificationFrequency = frequency;
    notifyListeners();
  }
}
