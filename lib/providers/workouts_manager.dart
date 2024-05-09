import 'package:fit_rep/config.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:flutter/material.dart';

class WorkoutsManager extends ChangeNotifier {
  final List<Workout> _workouts = appWorkouts;
  final Map<String, List<Workout>> plannedWorkouts = {
    '15/5/2024': [
      PlannedWorkout(
          Workout(
            'Full Body Workout',
            {},
          ),
          DateTime(2024, 5, 15, 10, 0, 0, 0, 0)),
      PlannedWorkout(
          Workout(
            'Full Body Workout',
            {},
          ),
          DateTime(2024, 5, 15, 10, 0, 0, 0, 0)),
      PlannedWorkout(
          Workout(
            'Full Body Workout',
            {},
          ),
          DateTime(2024, 5, 15, 10, 0, 0, 0, 0))
    ],
  };
  final Map<String, List<Workout>> completedWorkouts = {};

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  List<Workout> get workouts => _workouts;
  Workout? getWorkoutById(String id) => _workouts.firstWhere((w) => w.id == id);

  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  void removeWorkout(Workout workout) {
    _workouts.remove(workout);
    notifyListeners();
  }

  void updateWorkout(Workout workout) {
    final index = _workouts.indexWhere((w) => w.id == workout.id);
    _workouts[index] = workout;
    notifyListeners();
  }

  List<Workout> getCreatedWorkouts() {
    return _workouts
        .where((w) => !(w is PlannedWorkout || w is CompletedWorkout))
        .toList();
  }

  List<Workout> getTodayWorkouts() {
    final now = DateTime.now();
    return _workouts.where((w) {
      if (w is PlannedWorkout) {
        return w.date.year == now.year &&
            w.date.month == now.month &&
            w.date.day == now.day;
      }
      return false;
    }).toList();
  }

  List<Workout> getScheduledWorkouts() {
    return [
      ...plannedWorkouts.values.expand((e) => e),
      ...completedWorkouts.values.expand((e) => e)
    ];
  }

  void addPlannedWorkout(DateTime date, Workout workout) {
    if (date.isBefore(DateTime.now())) {
      throw Exception('The date of the workout is in the past.');
    }
    String dateString = formatDate(date);
    if (plannedWorkouts.containsKey(dateString)) {
      plannedWorkouts[dateString]!.add(workout);
    } else {
      plannedWorkouts[dateString] = [workout];
    }
    notifyListeners();
  }

  void addCompletedWorkout(DateTime date, Workout workout) {
    if (date.isAfter(DateTime.now())) {
      throw Exception('The date of the workout is in the future.');
    }
    String dateString = formatDate(date);
    if (workout is PlannedWorkout) plannedWorkouts[dateString]?.remove(workout);
    if (completedWorkouts.containsKey(dateString)) {
      completedWorkouts[dateString]!.add(workout);
    } else {
      completedWorkouts[dateString] = [workout];
    }
    notifyListeners();
  }

  List<Workout> getWorkoutsByDay(DateTime date) {
    String dateString = formatDate(date);
    return [
      ...(plannedWorkouts[dateString] ?? []),
      ...(completedWorkouts[dateString] ?? [])
    ];
  }
}
