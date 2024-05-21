import 'package:flutter/material.dart';

class ExerciseInfoSection extends StatelessWidget {
  final String exerciseName;
  final int currentExerciseIndex;
  final int totalExercises;
  final int currentSetIndex;
  final int totalSets;

  const ExerciseInfoSection({
    required this.exerciseName,
    required this.currentExerciseIndex,
    required this.totalExercises,
    required this.currentSetIndex,
    required this.totalSets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Exercise $exerciseName',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 10),
        Text(
          'Exercise ${currentExerciseIndex + 1}/$totalExercises',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          'Set ${currentSetIndex + 1}/$totalSets',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
