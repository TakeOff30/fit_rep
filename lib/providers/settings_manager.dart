import 'package:fit_rep/themes.dart';
import 'package:flutter/material.dart';

class SettingsManager extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isNotificationEnabled = true;
  int _height = 180;
  int _weight = 70;
  int _notificationFrequency = 0;
  ThemeData _mainTheme = FitRepTheme.light();
  int weeklyWorkoutGoal = 3;

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

  void setWeeklyWorkoutGoal(int goal) {
    weeklyWorkoutGoal = goal;
    notifyListeners();
  }

  void setNotificationFrequency(int frequency) {
    _notificationFrequency = frequency;
    notifyListeners();
  }

  // void loadSettings() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _isDarkMode = prefs.getBool('isDarkMode') ?? false;
  //   _isNotificationEnabled = prefs.getBool('isNotificationEnabled') ?? true;
  //   _height = prefs.getInt('height') ?? 180;
  //   _weight = prefs.getInt('weight') ?? 70;
  //   _notificationFrequency = prefs.getInt('notificationFrequency') ?? 0;
  //   _mainTheme = isDarkMode ? FitRepTheme.dark() : FitRepTheme.light();
  //   notifyListeners();
  // }

  // Future<void> saveSettings() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('isDarkMode', isDarkMode);
  //   prefs.setBool('isNotificationEnabled', isNotificationEnabled);
  //   prefs.setInt('height', height);
  //   prefs.setInt('weight', weight);
  //   prefs.setInt('notificationFrequency', notificationFrequency);
  // }
}
