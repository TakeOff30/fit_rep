import 'dart:convert';

import 'package:fit_rep/enums.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:flutter/foundation.dart';

class StatisticsManager extends ChangeNotifier {
  Map<String, int> _weeklyCalories = {
    'Monday': 0,
    'Tuesday': 200,
    'Wednesday': 50,
    'Thursday': 300,
    'Friday': 200,
    'Saturday': 500,
    'Sunday': 0,
  };

  Map<Muscle, double> _trainedMuscles = {
    Muscle.chest: 0,
    Muscle.back: 4,
    Muscle.biceps: 3,
    Muscle.triceps: 0,
    Muscle.quads: 7,
    Muscle.glutes: 0,
    Muscle.hamstrings: 1,
    Muscle.shoulders: 0,
    Muscle.calves: 5,
    Muscle.forearms: 0,
    Muscle.abs: 0,
  };

  int _workoutsCompleted = 0;
  int _totalWeeklyWorkoutsCompleted = 0;
  Duration _totalWorkoutDuration = Duration(hours: 2, minutes: 30);
  int userLevel = 1;
  int totalXPToLevelUp = 100;
  int currentXP = 0;

  Map<String, int> get weeklyCalories => _weeklyCalories;
  Map<Muscle, double> get trainedMuscles => _trainedMuscles;
  int get workoutsCompleted => _workoutsCompleted;
  Duration get totalWorkoutDuration => _totalWorkoutDuration;
  int get totalWeeklyWorkoutsCompleted => _totalWeeklyWorkoutsCompleted;

  void updateCalories(String day, int value) {
    _weeklyCalories[day] = (_weeklyCalories[day] ?? 0) + value;
    notifyListeners();
  }

  void updateXP(int value) {
    totalXPToLevelUp = 100 * userLevel;
    currentXP += value;
    if (currentXP >= totalXPToLevelUp) {
      userLevel++;
      currentXP = currentXP - totalXPToLevelUp;
    }
    notifyListeners();
  }

  void updateMuscle(Muscle muscle, bool secondaryMuscle) {
    if (secondaryMuscle) {
      _trainedMuscles[muscle] = (_trainedMuscles[muscle] ?? 0) + 0.5;
      notifyListeners();
    } else {
      _trainedMuscles[muscle] = (_trainedMuscles[muscle] ?? 0) + 1;
      notifyListeners();
    }
  }

  void resetStatistics() {
    _weeklyCalories = {
      'Monday': 0,
      'Tuesday': 0,
      'Wednesday': 0,
      'Thursday': 0,
      'Friday': 0,
      'Saturday': 0,
      'Sunday': 0,
    };
    notifyListeners();
  }

  void resetMuscles() {
    _trainedMuscles = {
      Muscle.chest: 0,
      Muscle.back: 0,
      Muscle.biceps: 0,
      Muscle.triceps: 0,
      Muscle.quads: 0,
      Muscle.glutes: 0,
      Muscle.hamstrings: 0,
      Muscle.shoulders: 0,
      Muscle.calves: 0,
      Muscle.forearms: 0,
      Muscle.abs: 0,
    };
    notifyListeners();
  }

  void incrementWorkoutsCompleted() {
    _workoutsCompleted++;
    _totalWeeklyWorkoutsCompleted++;
    notifyListeners();
  }

  void resetWeeklyWorkoutsCompleted() {
    _workoutsCompleted = 0;
    notifyListeners();
  }

  void updateTotalWorkoutDuration(Duration duration) {
    _totalWorkoutDuration += duration;
    notifyListeners();
  }

  // Future<void> saveStatistics() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('weeklyCalories', jsonEncode(_weeklyCalories));
  //   await prefs.setString('trainedMuscles', jsonEncode(_trainedMuscles));
  //   await prefs.setInt('workoutsCompleted', _workoutsCompleted);
  //   await prefs.setInt(
  //       'totalWeeklyWorkoutsCompleted', _totalWeeklyWorkoutsCompleted);
  //   await prefs.setInt('totalWorkoutDuration', _totalWorkoutDuration.inMinutes);
  //   await prefs.setInt('userLevel', userLevel);
  //   await prefs.setInt('totalXPToLevelUp', totalXPToLevelUp);
  //   await prefs.setInt('currentXP', currentXP);
  // }

  // Future<void> loadStatistics() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _weeklyCalories = jsonDecode(prefs.getString('weeklyCalories') ?? '{}')
  //       .map<String, int>((key, value) => MapEntry(key, value as int));
  //   _trainedMuscles = jsonDecode(prefs.getString('trainedMuscles') ?? '{}')
  //       .map<Muscle, double>((key, value) =>
  //           MapEntry(Muscle.values[int.parse(key)], value as double));
  //   _workoutsCompleted = prefs.getInt('workoutsCompleted') ?? 0;
  //   _totalWeeklyWorkoutsCompleted =
  //       prefs.getInt('totalWeeklyWorkoutsCompleted') ?? 0;
  //   _totalWorkoutDuration =
  //       Duration(minutes: prefs.getInt('totalWorkoutDuration') ?? 0);
  //   userLevel = prefs.getInt('userLevel') ?? 1;
  //   totalXPToLevelUp = prefs.getInt('totalXPToLevelUp') ?? 100;
  //   currentXP = prefs.getInt('currentXP') ?? 0;
  // }
}
