import 'package:fit_rep/components/workout_execution/calories_timer_section.dart';
import 'package:fit_rep/components/workout_execution/control_buttons.dart';
import 'package:fit_rep/components/workout_execution/execution_section.dart';
import 'package:fit_rep/components/workout_execution/exercise_info_section.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/providers/settings_manager.dart';
import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:fit_rep/screens/workout_termination_screen.dart';
import 'package:fit_rep/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class WorkoutExecutionScreen extends StatefulWidget {
  final Workout workout;

  const WorkoutExecutionScreen({required this.workout});

  @override
  _WorkoutExecutionScreenState createState() => _WorkoutExecutionScreenState();
}

class _WorkoutExecutionScreenState extends State<WorkoutExecutionScreen> {
  int currentExerciseIndex = 0;
  int currentSetIndex = 0;
  Timer? _globalTimer;
  Timer? _timer;
  Timer? _preparationTimer;
  int _globalTimerCounter = 0;
  int _preparationTimerCounter = 5;
  int _exerciseTimerCounter = 0;
  double _percent = 1.0;
  bool _isRunningExercise = false;
  bool _isRunningGlobal = true;
  bool _isPreparationRunning = false;
  double caloriesCounter = 0;
  ExerciseSet? currentSet;
  final playerStart = AudioPlayer();
  final playerDoneExercise = AudioPlayer();
  late AudioPlayer player = AudioPlayer();
  late AudioPlayer player2 = AudioPlayer();
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    player.setAsset('assets/sounds/notification.mp3');
    player.play();
    player2.setAsset('assets/sounds/done.mp3');
    flutterTts.setLanguage("en-US");
    flutterTts.setSpeechRate(1.0);
    flutterTts.setVolume(1.0);
    flutterTts.speak(
        'The first exercise is ${widget.workout.exercises.keys.toList()[currentExerciseIndex].name}');
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      print('Global timer running');
      if (mounted) {
        setState(() {
          if (_isRunningGlobal) _globalTimerCounter++;
        });
      }
    });

    _initializeCurrentSet();
    _startPreparationTimer();
  }

  void _initializeCurrentSet() {
    currentSet = widget.workout.exercises.values.toList()[currentExerciseIndex]
        [currentSetIndex];
    _exerciseTimerCounter = currentSet!.executionTime.inSeconds;
    _percent = 1.0;
  }

  void _startPreparationTimer() {
    _isPreparationRunning = true;
    _preparationTimerCounter = 5; // Reset preparation timer counter
    _cancelTimers(); // Cancel any running timers
    _preparationTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_preparationTimerCounter > 0 && _isRunningGlobal) {
          _preparationTimerCounter--;
        } else if (_preparationTimerCounter == 0) {
          _isPreparationRunning = false;
          _isRunningExercise = true;
          startExerciseTimer();
          timer.cancel();
        }
      });
    });
  }

  void startExerciseTimer() {
    const oneSec = Duration(seconds: 1);
    _cancelExerciseTimer();
    if (_isRunningExercise) {
      _timer = Timer.periodic(oneSec, (Timer timer) {
        setState(() {
          if (_exerciseTimerCounter == 0) {
            _isRunningExercise = false;
            timer.cancel();
            player2.play();
            player2.seek(Duration.zero);
          } else {
            _exerciseTimerCounter--;
            _percent =
                _exerciseTimerCounter / currentSet!.executionTime.inSeconds;
          }
        });
      });
    }
  }

  void _cancelTimers() {
    _preparationTimer?.cancel();
    _globalTimer?.cancel();
    _timer?.cancel();
  }

  void _cancelExerciseTimer() {
    _timer?.cancel();
  }

  void nextSetOrExercise() {
    setState(() {
      if (currentSetIndex <
          widget.workout.exercises.values
                  .toList()[currentExerciseIndex]
                  .length -
              1) {
        currentSetIndex++;
        player2.play();
        player2.seek(Duration.zero);
      } else {
        if (currentExerciseIndex < widget.workout.exercises.length - 1) {
          currentSetIndex = 0;
          currentExerciseIndex++;
          caloriesCounter += exerciseCaloriesBurned(
              widget.workout.exercises.keys.toList()[currentExerciseIndex],
              widget.workout.exercises.values.toList()[currentExerciseIndex],
              Provider.of<SettingsManager>(context, listen: false).weight);
          flutterTts.speak(
              'Next exercise is ${widget.workout.exercises.keys.toList()[currentExerciseIndex].name}');
          player2.play();
        } else {
          CompletedWorkout completedWorkout = CompletedWorkout(
            widget.workout,
            DateTime.now(),
            caloriesCounter.toInt(),
            Duration(seconds: _globalTimerCounter),
          );
          Provider.of<WorkoutsManager>(context, listen: false)
              .addCompletedWorkout(DateTime.now(), completedWorkout);

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WorkoutTerminationScreen(
              completedWorkout: completedWorkout,
            );
          }));
        }
      }
      _initializeCurrentSet();
      _startPreparationTimer();
    });
  }

  void togglePlayPause() {
    setState(() {
      _isRunningGlobal = !_isRunningGlobal;
      if (_isPreparationRunning) {
        // Pause or resume the preparation timer
        if (_preparationTimer != null && _preparationTimer!.isActive) {
          _preparationTimer!.cancel();
        } else {
          _startPreparationTimer();
        }
      } else if (_isRunningExercise) {
        if (_timer != null && _timer!.isActive) {
          _timer!.cancel();
        } else {
          startExerciseTimer();
        }
      }
    });
  }

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var settingsManager = Provider.of<SettingsManager>(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.workout.name,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ExerciseInfoSection(
                exerciseName: widget.workout.exercises.keys
                    .toList()[currentExerciseIndex]
                    .name,
                currentExerciseIndex: currentExerciseIndex,
                totalExercises: widget.workout.exercises.length,
                currentSetIndex: currentSetIndex,
                totalSets: widget.workout.exercises.values
                    .toList()[currentExerciseIndex]
                    .length,
              ),
              const SizedBox(height: 10),
              ExecutionSection(
                isTimed: currentSet!.isTimed,
                isPreparationRunning: _isPreparationRunning,
                percent: _percent,
                exerciseTimerCounter: _exerciseTimerCounter,
                preparationTimerCounter: _preparationTimerCounter,
                isDarkMode: settingsManager.isDarkMode,
                reps: currentSet!.reps,
                weight: currentSet!.weight.toDouble(),
              ),
              const SizedBox(height: 20), // Spacing below the timer
              ControlButtons(
                togglePlayPause: () {
                  togglePlayPause();
                },
                nextSetOrExercise: () {
                  nextSetOrExercise();
                },
                isRunningGlobal: _isRunningGlobal,
              ),
              SizedBox(height: 20),
              CaloriesTimerSection(
                  globalTimerCounter: _globalTimerCounter,
                  caloriesBurned: caloriesCounter.toInt()),
            ],
          ),
        ),
      ),
    );
  }
}
