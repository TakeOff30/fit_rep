import 'package:fit_rep/enums.dart';
import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:fit_rep/models/workout.dart';

List<Exercise> fitRepExercises = [
  Exercise(
    'Push-up',
    'A push-up is a common calisthenics exercise beginning from the prone position. By raising and lowering the body using the arms, push-ups exercise the pectoral muscles, triceps, and anterior deltoids, with ancillary benefits to the rest of the deltoids, serratus anterior, coracobrachialis and the midsection as a whole.',
    ExerciseType.bodyWeight,
    Muscle.chest,
    Muscle.triceps,
    8.0,
  ),
  Exercise(
    'Pull-up',
    'A pull-up is an upper-body strength exercise. The pull-up is a closed-chain movement where the body is suspended by the hands and pulls up. As this happens, the elbows flex and the shoulders adduct and extend to bring the elbows to the torso.',
    ExerciseType.bodyWeight,
    Muscle.back,
    Muscle.biceps,
    7.0,
  ),
  Exercise(
    'Squat',
    'The squat is a lower body exercise. The exercise works the quadriceps, hamstrings, glutes, lower back, and core. The squat is often called "the king of leg exercises" for its ability to build all muscle groups in the legs.',
    ExerciseType.bodyWeight,
    Muscle.quads,
    Muscle.glutes,
    6.0,
  ),
  Exercise(
    'Bench press',
    'The bench press is an upper-body strength-training exercise that consists of pressing a weight upwards from a supine position. The exercise works the pectoralis major as well as supporting chest, arm, and shoulder muscles such as the anterior deltoids, serratus anterior, coracobrachialis, scapulae fixers, trapezii, and the triceps.',
    ExerciseType.weightLifting,
    Muscle.chest,
    Muscle.triceps,
    7.0,
  ),
  Exercise(
    'Deadlift',
    'The deadlift is a weight training exercise in which a loaded barbell or bar is lifted off the ground to the level of the hips, then lowered to the ground. It is one of the three powerlifting exercises, along with the squat and bench press.',
    ExerciseType.weightLifting,
    Muscle.back,
    Muscle.glutes,
    8.0,
  ),
  Exercise(
    'Leg press',
    'The leg press is a weight training exercise in which the individual pushes a weight or resistance away from them using their legs. The term leg press also refers to the apparatus used to perform this exercise.',
    ExerciseType.weightLifting,
    Muscle.quads,
    Muscle.hamstrings,
    6.0,
  ),
  Exercise(
    'Treadmill',
    'A treadmill is a device generally used for walking, running, or climbing while staying in the same place. Treadmills were introduced before the development of powered machines to harness the power of animals or humans to do work, often a type of mill operated by a person or animal treading steps of a treadwheel to grind grain.',
    ExerciseType.cardio,
    Muscle.quads,
    Muscle.hamstrings,
    5.0,
  ),
  Exercise(
    'Stationary bike',
    'A stationary bicycle is a device with a saddle, pedals, and some form of handlebars arranged as on a bicycle, but used as exercise equipment rather than transportation. An exercise bicycle is usually a special-purpose exercise machine resembling a bicycle without true wheels, but it is also possible to adapt an ordinary bicycle for stationary exercise by placing it on bicycle rollers or a trainer.',
    ExerciseType.cardio,
    Muscle.quads,
    Muscle.hamstrings,
    6.0,
  ),
  Exercise(
    'Rowing machine',
    'A rowing machine is a type of exercise equipment that mimics the motion of rowing for the purpose of exercise or training for rowing. Indoor rowing has become established as a sport in its own right. The term also refers to a participant in this sport.',
    ExerciseType.cardio,
    Muscle.back,
    Muscle.biceps,
    7.0,
  ),
  Exercise(
    'Jump rope',
    'A skipping rope or jump rope is a tool used in the sport of skipping/jump rope where one or more participants jump over a rope swung so that it passes under their feet and over their heads. There are multiple subsets of skipping/jump rope, including single freestyle, single speed, pairs, three-person speed, and three-person freestyle.',
    ExerciseType.cardio,
    Muscle.calves,
    Muscle.forearms,
    8.0,
  ),
];

List<Workout> appWorkouts = [
  Workout('Chest Day', {
    fitRepExercises[0]: [
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
    ],
    fitRepExercises[1]: [
      ExerciseSet.repsSet(restTime: 60, reps: 20, weight: 10),
      ExerciseSet.repsSet(restTime: 60, reps: 20, weight: 10),
    ],
    fitRepExercises[0]: [
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
    ],
  }),
  Workout('Back Day', {
    fitRepExercises[1]: [
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
    ],
    fitRepExercises[4]: [
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
    ],
    fitRepExercises[5]: [
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
    ],
  }),
  Workout('Leg Day', {
    fitRepExercises[0]: [
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
    ],
    fitRepExercises[3]: [
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
    ],
    fitRepExercises[2]: [
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
    ],
    fitRepExercises[1]: [
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
      ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
    ],
  }),
  CompletedWorkout(
      Workout('Completed 1', {
        fitRepExercises[0]: [
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
        ],
        fitRepExercises[1]: [
          ExerciseSet.repsSet(restTime: 60, reps: 20, weight: 10),
          ExerciseSet.repsSet(restTime: 60, reps: 20, weight: 10),
        ],
        fitRepExercises[0]: [
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
        ],
      }),
      DateTime.utc(2024, 5, 5),
      500,
      Duration(minutes: 60)),
  CompletedWorkout(
      Workout('Completed 2', {
        fitRepExercises[0]: [
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
        ],
        fitRepExercises[1]: [
          ExerciseSet.repsSet(restTime: 60, reps: 20, weight: 10),
          ExerciseSet.repsSet(restTime: 60, reps: 20, weight: 10),
        ],
        fitRepExercises[0]: [
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
        ],
      }),
      DateTime.utc(2024, 4, 20),
      500,
      Duration(minutes: 60)),
  PlannedWorkout(
      Workout('Planned 1', {
        fitRepExercises[0]: [
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
        ],
        fitRepExercises[1]: [
          ExerciseSet.repsSet(restTime: 60, reps: 20, weight: 10),
          ExerciseSet.repsSet(restTime: 60, reps: 20, weight: 10),
        ],
        fitRepExercises[0]: [
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
          ExerciseSet.repsSet(reps: 10, weight: 135, restTime: 60),
        ],
      }),
      DateTime.utc(2024, 6, 20)),
];
