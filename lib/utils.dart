import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:fit_rep/providers/settings_manager.dart';
import 'package:provider/provider.dart';

String formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}

double exerciseCaloriesBurned(
    Exercise exercise, List<ExerciseSet> sets, int weight) {
  double exerciseCalories = 0;
  for (var exeSet in sets) {
    if (exeSet.isTimed) {
      exerciseCalories +=
          exercise.metValue * exeSet.executionTime.inSeconds * 3.5 * weight;
    } else {
      exerciseCalories += 0.025 *
          exeSet.weight *
          exeSet.reps *
          exercise.metValue *
          3.5 *
          weight;
    }
  }
  return exerciseCalories;
}
