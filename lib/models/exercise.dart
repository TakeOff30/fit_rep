import 'package:fit_rep/enums.dart';

class Exercise {
  final String name;
  int calories = 0;
  final String description;
  final ExerciseType type;
  final Muscle primaryMuscle;
  final Muscle secondaryMuscles;

  Exercise({
    required this.name,
    required this.description,
    required this.type,
    required this.primaryMuscle,
    required this.secondaryMuscles,
  });
}
