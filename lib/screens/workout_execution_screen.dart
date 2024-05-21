import 'package:fit_rep/components/calories_timer_section.dart';
import 'package:fit_rep/components/control_buttons.dart';
import 'package:fit_rep/components/exercise_info_section.dart';
import 'package:fit_rep/components/reps_weight_info_section.dart';
import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/providers/settings_manager.dart';
import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:fit_rep/screens/workout_termination_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fit_rep/utils.dart';
import 'dart:async';

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

  @override
  void initState() {
    super.initState();
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
      } else {
        if (currentExerciseIndex < widget.workout.exercises.length - 1) {
          currentSetIndex = 0;
          currentExerciseIndex++;
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
              (currentSet!.isTimed)
                  ? (!_isPreparationRunning)
                      ? CircularPercentIndicator(
                          radius: 150.0,
                          lineWidth: 20.0,
                          percent: _percent,
                          center: Text(
                            formatTime(_exerciseTimerCounter),
                            style: TextStyle(
                                fontSize: 40.0,
                                color: (settingsManager.isDarkMode)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          progressColor: Colors.green,
                          backgroundColor: Colors.grey,
                          circularStrokeCap: CircularStrokeCap.round,
                        )
                      : Text(
                          'Get ready in $_preparationTimerCounter seconds',
                          style: TextStyle(fontSize: 24),
                        )
                  : Container(
                      child: RepsAndWeightInfoSection(
                        reps: currentSet!.reps,
                        weight: currentSet!.weight,
                      ),
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
