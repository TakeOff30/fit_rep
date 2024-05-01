import 'package:fit_rep/config.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:flutter/material.dart';

class WorkoutsManager extends ChangeNotifier {
  final List<Workout> _workouts = appWorkouts;

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
}
