import 'package:fit_rep/components/exercise_list_element.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/screens/workout_creation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutPreviewScreen extends StatefulWidget {
  final Workout workout;

  const WorkoutPreviewScreen({required this.workout});

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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(children: [
                  for (var entry in widget.workout.exercises.entries)
                    ExerciseListElement(
                        exercise: entry.key,
                        sets: entry.value,
                        onTap: () {},
                        onDelete: () {},
                        canDelete: false)
                ]),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton.outlined(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WorkoutCreationScreen(
                                      toModify: widget.workout)));
                        },
                        icon: Icon(Icons.edit)),
                    IconButton.outlined(
                        onPressed: () {}, icon: Icon(Icons.play_arrow))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
