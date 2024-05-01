class ExerciseSet {
  int reps = 0;
  int restTime;
  int executionTime = 0;
  int weight = 0;
  final bool isTimed;

  ExerciseSet.repsSet({
    required this.restTime,
    required this.reps,
    required this.weight,
  }) : isTimed = false;

  ExerciseSet.timedSet({
    required this.restTime,
    required this.executionTime,
  }) : isTimed = true;
}
