import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/providers/settings_manager.dart';
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
  Timer? _timer;
  int _globalTimerCounter = 0;
  int _start = 0; // 1:30 in seconds
  double _percent = 1.0;
  bool _isRunning = false;
  double caloriesCounter = 0;
  ExerciseSet? currentSet;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_isRunning) _globalTimerCounter++;
      });
    });
    currentSet = widget.workout.exercises.values.toList()[currentExerciseIndex]
        [currentSetIndex];
    _start = currentSet!.executionTime.inSeconds;
  }

  void startTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
    } else {
      _isRunning = true;
      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(oneSec, (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _isRunning = false;
            nextExercise();
          });
        } else {
          setState(() {
            _start--;
            _percent =
                _start / currentSet!.executionTime.inSeconds; // Update percent
          });
        }
      });
    }
  }

  void nextExercise() {
    if (currentExerciseIndex < widget.workout.exercises.length - 1) {
      setState(() {
        currentSetIndex = 0;
        currentExerciseIndex++;
        currentSet = widget.workout.exercises.values
            .toList()[currentExerciseIndex][currentSetIndex];
        _start = currentSet!.executionTime.inSeconds;
      });
    } else {
      // End of workout
      print('Workout ended');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
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
              Column(
                children: [
                  Text(
                    'Exercise ${widget.workout.exercises.keys.toList()[currentExerciseIndex].name}',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Exercise ${currentExerciseIndex + 1}/${widget.workout.exercises.length}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Set ${currentSetIndex + 1}/${widget.workout.exercises.values.toList()[currentExerciseIndex].length}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              (
                      //currentSet!.isTimed
                      true)
                  ? CircularPercentIndicator(
                      radius: 150.0,
                      lineWidth: 20.0,
                      percent: _percent,
                      center: Text(
                        "${(_start ~/ 60).toString().padLeft(2, '0')}:${(_start % 60).toString().padLeft(2, '0')}",
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
                  : Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Reps',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                currentSet!.reps.toString(),
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Weight',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                currentSet!.weight.toString(),
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              const SizedBox(height: 20), // Spacing below the timer
              Container(
                height: 60,
                width: 250,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 0, 0, 0), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      onPressed: startTimer,
                      tooltip: _isRunning ? 'Pause Timer' : 'Start Timer',
                      child: Icon(Icons.pause, color: Colors.green, size: 40),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    FloatingActionButton(
                      onPressed: startTimer,
                      tooltip: _isRunning ? 'Pause Timer' : 'Start Timer',
                      child: Icon(Icons.check, color: Colors.green, size: 40),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * .4,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Burned: $caloriesCounter kcal',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * .4,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Total time: $_globalTimerCounter',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
