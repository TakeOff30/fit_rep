import 'package:fit_rep/config.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:fit_rep/utils.dart';

class WorkoutsManager extends ChangeNotifier {
  List<Workout> _workouts = appWorkouts;
  final Map<String, List<Workout>> plannedWorkouts = {
    '25/5/2024': [
      PlannedWorkout(
          Workout(
            'Full Body Workout',
            {},
          ),
          DateTime(2024, 5, 25, 10, 0, 0, 0, 0)),
      PlannedWorkout(
          Workout(
            'Full Body Workout',
            {},
          ),
          DateTime(2024, 5, 25, 10, 0, 0, 0, 0)),
      PlannedWorkout(
          Workout(
            'Full Body Workout',
            {},
          ),
          DateTime(2024, 5, 25, 10, 0, 0, 0, 0)),
    ],
    '13/5/2024': [
      CompletedWorkout(
          Workout('Today 1', {
            fitRepExercises[0]: [
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 10)),
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 10)),
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 10)),
            ],
            fitRepExercises[1]: [
              ExerciseSet.repsSet(
                  restTime: Duration(minutes: 0, seconds: 10),
                  reps: 20,
                  weight: 10),
              ExerciseSet.repsSet(
                  restTime: Duration(minutes: 0, seconds: 10),
                  reps: 20,
                  weight: 10),
            ],
            fitRepExercises[0]: [
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 10)),
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 10)),
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 10)),
            ],
          }),
          DateTime(2024, 5, 13, 10, 0, 0, 0, 0),
          500,
          Duration(minutes: 60)),
    ],
  };
  final Map<String, List<Workout>> completedWorkouts = {
    '5/5/2024': [
      CompletedWorkout(
          Workout('Completed 1', {
            fitRepExercises[0]: [
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 60)),
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 60)),
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 60)),
            ],
            fitRepExercises[1]: [
              ExerciseSet.repsSet(
                  restTime: Duration(minutes: 0, seconds: 60),
                  reps: 20,
                  weight: 10),
              ExerciseSet.repsSet(
                  restTime: Duration(minutes: 0, seconds: 60),
                  reps: 20,
                  weight: 10),
            ],
            fitRepExercises[0]: [
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 60)),
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 60)),
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 60)),
            ],
          }),
          DateTime.utc(2024, 5, 5),
          500,
          Duration(minutes: 60)),
      CompletedWorkout(
          Workout('Completed 2', {
            fitRepExercises[0]: [
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 60)),
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 60)),
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 60)),
            ],
            fitRepExercises[1]: [
              ExerciseSet.repsSet(
                  restTime: Duration(minutes: 0, seconds: 60),
                  reps: 20,
                  weight: 10),
              ExerciseSet.repsSet(
                  restTime: Duration(minutes: 0, seconds: 60),
                  reps: 20,
                  weight: 10),
            ],
            fitRepExercises[0]: [
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 60)),
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 60)),
              ExerciseSet.repsSet(
                  reps: 10,
                  weight: 135,
                  restTime: Duration(minutes: 0, seconds: 60)),
            ],
          }),
          DateTime.utc(2024, 4, 20),
          500,
          Duration(minutes: 60)),
    ],
  };

  List<Workout> get workouts => _workouts;
  Workout? getWorkoutById(String id) => _workouts.firstWhere((w) => w.id == id);

  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  void modifyWorkout(Workout toModify, Workout workout) {
    int index = _workouts.indexWhere((w) => w.id == toModify.id);
    if (index == -1) {
      index = plannedWorkouts.values
          .expand((e) => e)
          .toList()
          .indexWhere((w) => w.id == toModify.id);
      plannedWorkouts.values.expand((e) => e).toList()[index] =
          workout as PlannedWorkout;
      notifyListeners();
      return;
    }
    _workouts[index] = workout;
    notifyListeners();
  }

  void removeWorkout(Workout workout) {
    print(plannedWorkouts.length);
    if (workout is PlannedWorkout) {
      print('removing');
      plannedWorkouts[formatDate(workout.date)]?.remove(workout);
      notifyListeners();
      return;
    } else if (workout is CompletedWorkout) {
      completedWorkouts[formatDate(workout.date)]?.remove(workout);
      notifyListeners();
      return;
    } else {
      _workouts.remove(workout);
      notifyListeners();
    }
    print(plannedWorkouts.length);
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
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    int day = DateTime.now().day;
    DateTime todaysDate = DateTime(year, month, day, 0, 0, 0, 0, 0);
    if (date.isBefore(todaysDate)) {
      throw Exception('The date of the workout is in the past.');
    }
    String dateString = formatDate(date);
    PlannedWorkout toAdd = PlannedWorkout(workout, date);
    if (plannedWorkouts.containsKey(dateString)) {
      plannedWorkouts[dateString]!.add(toAdd);
    } else {
      plannedWorkouts[dateString] = [toAdd];
    }
    notifyListeners();
  }

  void addCompletedWorkout(DateTime date, Workout workout) {
    if (date.isAfter(DateTime.now().add(Duration(minutes: 1)))) {
      throw Exception('The date of the workout is in the future.');
    }
    String dateString = formatDate(date);
    if (workout is PlannedWorkout) plannedWorkouts[dateString]?.remove(workout);

    if (completedWorkouts.containsKey(dateString)) {
      completedWorkouts[dateString]!.add(workout as CompletedWorkout);
    } else {
      completedWorkouts[dateString] = [workout as CompletedWorkout];
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

  // Future<void> saveWorkouts() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('workouts', jsonEncode(_workouts));
  // }

  // Future<void> loadWorkouts() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final workoutsString = prefs.getString('workouts');
  //   if (workoutsString != null) {
  //     _workouts = jsonDecode(workoutsString);
  //   }
  // }
}
