import 'package:fit_rep/enums.dart';
import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:fit_rep/models/workout.dart';

List<Workout> appWorkouts = [
  Workout(name: 'Chest Day', exercises: {
    Exercise(
      name: 'Bench Press',
      description: 'Lay on bench and press barbell',
      type: ExerciseType.strength,
      primaryMuscle: Muscle.chest,
      secondaryMuscle: Muscle.triceps,
    ): [
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
    ],
    Exercise(
      name: 'Incline Bench Press',
      description: 'Lay on incline bench and press barbell',
      type: ExerciseType.strength,
      primaryMuscle: Muscle.chest,
      secondaryMuscle: Muscle.triceps,
    ): [
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
    ],
    Exercise(
      name: 'Decline Bench Press',
      description: 'Lay on decline bench and press barbell',
      type: ExerciseType.strength,
      primaryMuscle: Muscle.chest,
      secondaryMuscle: Muscle.triceps,
    ): [
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
    ],
  }),
  Workout(name: 'Leg Day', exercises: {
    Exercise(
      name: 'Squats',
      description: 'Stand with barbell on shoulders and squat',
      type: ExerciseType.strength,
      primaryMuscle: Muscle.quads,
      secondaryMuscle: Muscle.glutes,
    ): [
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
    ],
    Exercise(
      name: 'Leg Press',
      description: 'Sit on leg press machine and press',
      type: ExerciseType.strength,
      primaryMuscle: Muscle.quads,
      secondaryMuscle: Muscle.glutes,
    ): [
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
    ],
    Exercise(
      name: 'Leg Curls',
      description: 'Lay on leg curl machine and curl',
      type: ExerciseType.strength,
      primaryMuscle: Muscle.hamstrings,
      secondaryMuscle: Muscle.glutes,
    ): [
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet(reps: 10, weight: 135, restTime: 60),
    ],
  }),
];
