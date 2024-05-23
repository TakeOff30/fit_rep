import 'package:fit_rep/components/generics/exercise_list_element.dart';
import 'package:fit_rep/config.dart';
import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/providers/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:fit_rep/screens/exercises_selection.dart';
import 'package:fit_rep/screens/set_selection.dart';

class WorkoutCreationScreen extends StatefulWidget {
  final Workout? toModify;
  DateTime? date;

  WorkoutCreationScreen({super.key, this.date, this.toModify});
  @override
  _WorkoutCreationScreenState createState() => _WorkoutCreationScreenState();
}

class _WorkoutCreationScreenState extends State<WorkoutCreationScreen> {
  Workout workout = Workout('', {
    fitRepExercises[0]: [
      ExerciseSet.repsSet(
          restTime: Duration(minutes: 0, seconds: 0), reps: 0, weight: 0)
    ]
  });

  TextEditingController workoutNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.toModify != null) {
      workout = widget.toModify!;
    }
    workoutNameController = TextEditingController(text: workout.name);
  }

  @override
  void dispose() {
    workoutNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var workoutsProvider = Provider.of<WorkoutsManager>(context);
    var settingsManager = Provider.of<SettingsManager>(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
            (widget.toModify != null) ? "Modify Workout" : "Create Workout",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Kanit',
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: workoutNameController,
                    onChanged: (value) {
                      setState(() {
                        workout.name = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Workout name',
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' %d Exercises'.replaceAll(
                            '%d', workout.exercises.length.toString()),
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: Icon(Icons.add,
                            color: Theme.of(context).primaryColor),
                        iconSize: 48,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ExercisesSelection((Exercise exe) {
                                setState(() {
                                  if (workout.exercises[exe] == null)
                                    workout.exercises[exe] = [];
                                });
                              }),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  (workout.exercises.entries.length == 0)
                      ? Text('No exercises yet...')
                      : SizedBox(height: 20),
                  ...workout.exercises.entries
                      .map((entry) => Container(
                            margin: EdgeInsets.all(8),
                            child: ExerciseListElement(
                              exercise: entry.key,
                              sets: entry.value,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SetSelection(
                                        entry.value, (List<ExerciseSet> sets) {
                                      setState(() {
                                        workout.exercises[entry.key] = sets;
                                      });
                                    }),
                                  ),
                                );
                              },
                              onDelete: (Exercise toRemove) {
                                setState(() {
                                  workout.exercises.remove(toRemove);
                                });
                              },
                            ),
                          ))
                      .toList()
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: ElevatedButton(
              onPressed: () {
                if (workout.name.isEmpty && workout.exercises.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(
                            'Please fill out the workout name and add at least one exercise.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else if (workout.name.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Please fill out the workout name.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else if (workout.exercises.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Please add at least one exercise.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  print(widget.date);
                  if (widget.toModify != null) {
                    workoutsProvider.modifyWorkout(widget.toModify!, workout);
                    Navigator.of(context).pop();
                  } else {
                    if (widget.date != null) {
                      workoutsProvider.addPlannedWorkout(widget.date!, workout);
                    } else {
                      workoutsProvider.addWorkout(workout);
                    }
                    Navigator.of(context).pop();
                  }
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                fixedSize: Size(170, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
