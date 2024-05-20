import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/enums.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:uuid/uuid.dart';

class Workout {
  final String id = const Uuid().v4();
  String name;
  final Map<Exercise, List<ExerciseSet>> exercises;

  Workout(
    this.name,
    this.exercises,
  );

  List<String> exerciseTypes() {
    return exercises.keys
        .map((e) => e.type.name.toLowerCase())
        .toSet()
        .toList();
  }

  List<String> muscles() {
    List<String> muscles = [];
    muscles
        .addAll(exercises.keys.map((e) => e.primaryMuscle.name.toLowerCase()));
    muscles.addAll(
        exercises.keys.map((e) => e.secondaryMuscle.name.toLowerCase()));
    return muscles;
  }

  double calculateCaloriesBurned(int userWeight) {
    double totalCalories = 0;
    exercises.forEach((exercise, sets) {
      double exerciseCalories = 0;
      for (var exeSet in sets) {
        if (exeSet.isTimed) {
          exerciseCalories += exercise.metValue *
              exeSet.executionTime.inSeconds *
              3.5 *
              userWeight;
        } else {
          exerciseCalories += 0.025 *
              exeSet.weight *
              exeSet.reps *
              exercise.metValue *
              3.5 *
              userWeight;
        }
      }
      totalCalories += exerciseCalories;
    });
    return totalCalories;
  }

  int calculateXP() {
    int totalXP = 0;
    exercises.forEach((exercise, sets) {
      int exerciseXP = 0;
      for (var exeSet in sets) {
        if (exeSet.isTimed) {
          exerciseXP += exeSet.executionTime.inSeconds;
        } else {
          exerciseXP += exeSet.reps * 5;
        }
      }
      totalXP += exerciseXP;
    });
    return totalXP;
  }
}

class CompletedWorkout extends Workout {
  final DateTime date;
  final int burnedCalories;
  final Duration duration;

  @override
  final String id = const Uuid().v4();

  CompletedWorkout(workout, this.date, this.burnedCalories, this.duration)
      : super(workout.name, workout.exercises);
}

class PlannedWorkout extends Workout {
  @override
  final String id = const Uuid().v4();
  final DateTime date;
  bool isDone = false;

  set done(bool value) {
    isDone = value;
  }

  PlannedWorkout(workout, this.date) : super(workout.name, workout.exercises);

  bool isToday() {
    return DateTime.now().day == date.day &&
        DateTime.now().month == date.month &&
        DateTime.now().year == date.year;
  }
}
