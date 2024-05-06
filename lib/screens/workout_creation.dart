import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkoutCreation extends StatefulWidget {
  @override
  _WorkoutCreationState createState() => _WorkoutCreationState();
}

class _WorkoutCreationState extends State<WorkoutCreation> {
  @override
  Widget build(BuildContext context) {
    var workoutsProvider = Provider.of<WorkoutsManager>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(),
    );
  }
}
