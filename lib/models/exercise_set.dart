class ExerciseSet {
  int reps = 0;
  Duration restTime;
  Duration executionTime = Duration(minutes: 0, seconds: -1);
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
    required this.weight,
  }) : isTimed = true;
}
