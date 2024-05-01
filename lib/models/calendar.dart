import 'workout.dart';

class Calendar {
  final Map<String, List<Workout>> plannedWorkouts = {};
  List<Workout> todayWorkouts = [];
  final Map<String, List<Workout>> completedWorkouts = {};

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
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
  }

  void addTodayWorkouts(Workout workout) {
    todayWorkouts = plannedWorkouts[formatDate(DateTime.now())] ?? [];
    plannedWorkouts.remove(formatDate(DateTime.now()));
  }

  void addCompletedWorkout(DateTime date, Workout workout) {
    if (date.isAfter(DateTime.now())) {
      throw Exception('The date of the workout is in the future.');
    }
    todayWorkouts.remove(workout);
    String dateString = formatDate(date);
    if (completedWorkouts.containsKey(dateString)) {
      completedWorkouts[dateString]!.add(workout);
    } else {
      completedWorkouts[dateString] = [workout];
    }
  }
}
