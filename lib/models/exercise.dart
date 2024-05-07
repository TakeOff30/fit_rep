import 'package:fit_rep/enums.dart';

class Exercise {
  final String name;
  final String description;
  final ExerciseType type;
  final Muscle primaryMuscle;
  final Muscle secondaryMuscle;
  final double metValue;

  Exercise(this.name, this.description, this.type, this.primaryMuscle,
      this.secondaryMuscle, this.metValue);
}
