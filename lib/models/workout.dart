import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/enums.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:uuid/uuid.dart';

class Workout {
  final String id = const Uuid().v4();
  final String name;
  final Map<Exercise, List<ExerciseSet>> exercises;

  Workout(
    this.name,
    this.exercises,
  );

  List<ExerciseType> exerciseTypes() {
    return exercises.keys.map((e) => e.type).toList();
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

  double calculateCaloriesBurned(double userWeight) {
    double totalCalories = 0;
    exercises.forEach((exercise, sets) {
      double exerciseCalories = 0;
      for (var exeSet in sets) {
        if (exeSet.isTimed) {
          exerciseCalories +=
              exercise.metValue * exeSet.executionTime * 3.5 * userWeight;
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
}

class PlannedWorkout extends Workout {
  @override
  final String id = const Uuid().v4();
  final DateTime date;

  PlannedWorkout(workout, this.date) : super(workout.name, workout.exercises);
}
