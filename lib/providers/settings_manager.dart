import 'package:fit_rep/themes.dart';
import 'package:flutter/material.dart';

class SettingsManager extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isNotificationEnabled = true;
  int _height = 180;
  int _weight = 70;
  ThemeData _mainTheme = FitRepTheme.light();

  bool get isDarkMode => _isDarkMode;
  bool get isNotificationEnabled => _isNotificationEnabled;
  int get height => _height;
  int get weight => _weight;
  ThemeData get theme => _mainTheme;

  void toggleDarkMode() {
    _isDarkMode = !isDarkMode;
    _mainTheme = isDarkMode ? FitRepTheme.dark() : FitRepTheme.light();
  }

  void toggleNotification() {
    _isNotificationEnabled = !isNotificationEnabled;
  }

  void setHeight(int height) {
    _height = height;
  }

  void setWeight(int weight) {
    _weight = weight;
  }
}
