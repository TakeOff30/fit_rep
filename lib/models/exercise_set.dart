import 'package:fit_rep/models/exercise.dart';

class ExerciseSet {
  int reps = 0;
  int restTime;
  int executionTime = 0;
  int weight = 0;
  Exercise exercise;
  final bool isTimed;

  ExerciseSet.repsSet({
    required this.restTime,
    required this.reps,
    required this.weight,
    required this.exercise,
  }) : isTimed = false;

  ExerciseSet.timedSet({
    required this.restTime,
    required this.executionTime,
    required this.exercise,
  }) : isTimed = true;

  double countCalories(double userWeight) {
    if (isTimed) {
      return exercise.metValue * executionTime * 3.5 * userWeight;
    } else {
      return 0.025 * weight * reps * exercise.metValue * 3.5 * userWeight;
    }
  }
}
