class ExerciseSet {
  int reps;
  int restTime;
  int executionTime;
  int weight;

  ExerciseSet({
    required this.restTime,
    this.reps = -1,
    this.executionTime = -1,
    this.weight = -1,
  });
}
