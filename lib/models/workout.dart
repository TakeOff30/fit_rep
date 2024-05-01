import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/enums.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:uuid/uuid.dart';

class Workout {
  final String id;
  final String name;
  final Map<Exercise, List<ExerciseSet>> exercises;

  Workout({
    required this.name,
    required this.exercises,
  }) : id = const Uuid().v4();

  List<ExerciseType> exerciseTypes() {
    return exercises.keys.map((e) => e.type).toList();
  }
}

class PlannedWorkout extends Workout {
  DateTime plannedDate;

  PlannedWorkout({
    required Workout workout,
    required this.plannedDate,
  }) : super(name: workout.name, exercises: workout.exercises);
}

class CompletedWorkout extends Workout {
  final DateTime completedDate;

  CompletedWorkout({
    required String name,
    required Map<Exercise, List<ExerciseSet>> exercises,
    required this.completedDate,
  }) : super(name: name, exercises: exercises);
}
