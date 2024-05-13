import 'package:fit_rep/components/exercise_list_element.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:flutter/material.dart';

class WorkoutPreviewScreen extends StatefulWidget {
  final Workout workout;

  const WorkoutPreviewScreen({Key? key, required this.workout})
      : super(key: key);

  @override
  _WorkoutPreviewScreenState createState() => _WorkoutPreviewScreenState();
}

class _WorkoutPreviewScreenState extends State<WorkoutPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.workout.name,
        style: Theme.of(context).textTheme.headlineLarge,
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(children: [
        for (var entry in widget.workout.exercises.entries)
          ExerciseListElement(
              exercise: entry.key, sets: entry.value, onTap: () {}, onDelete: () {})
      ]),
      Row(
        children: [
          IconButton.outlined(onPressed: () {}, icon: Icon(Icons.change_circle)),
          IconButton.outlined(onPressed: () {}, icon: Icon(Icons.start))
        ],
      )
        ],
      )
      
      
    );
  }
}
