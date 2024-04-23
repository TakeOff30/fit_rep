import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/enums.dart';
import 'package:uuid/uuid.dart';

class Workout {
  final String id;
  final String name;
  final DateTime date;
  final Map<Exercise, List<Set>> exercises;

  Workout({
    required this.name,
    required this.exercises,
  }) : id = const Uuid().v4();

  List<ExerciseType> exerciseTypes() {
    return exercises.keys.map((e) => e.type).toList();
  }
}

class PlannedWorkout extends Workout {
  // passo il workout nel costruttore
  PlannedWorkout({
    required String name,
    required Map<Exercise, List<Set>> exercises,
  }) : super(name: name, exercises: exercises);
}

class CompletedWorkout extends Workout {
  final DateTime completedDate;

  CompletedWorkout({
    required String name,
    required Map<Exercise, List<Set>> exercises,
    required this.completedDate,
  }) : super(name: name, exercises: exercises);
}
