import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/utils.dart';
import 'package:flutter/material.dart';

class WorkoutTerminationScreen extends StatelessWidget {
  CompletedWorkout completedWorkout;

  WorkoutTerminationScreen({required this.completedWorkout});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Workout Terminated!'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You did an amazing job! Here are your stats:',
              ),
              SizedBox(height: 20),
              Text(
                'Total time: ${formatTime(completedWorkout.duration.inSeconds)}',
              ),
              SizedBox(height: 10),
              Text(
                'Total calories burned: ${completedWorkout.burnedCalories}',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Icon(Icons.check),
        ));
  }
}
