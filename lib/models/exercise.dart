import 'package:fit_rep/enums.dart';

class Exercise {
  final String name;
  final String description;
  final ExerciseType type;
  final Muscle primaryMuscle;
  final Muscle secondaryMuscles;
  final double metValue;

  Exercise(this.name, this.description, this.type, this.primaryMuscle,
      this.secondaryMuscles, this.metValue);
}
