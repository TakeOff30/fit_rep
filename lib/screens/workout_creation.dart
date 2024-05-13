import 'package:fit_rep/components/exercise_list_element.dart';
import 'package:fit_rep/config.dart';
import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:fit_rep/screens/exercises_selection.dart';
import 'package:fit_rep/screens/set_selection.dart';

class WorkoutCreation extends StatefulWidget {
  DateTime? date;

  WorkoutCreation(this.date);
  @override
  _WorkoutCreationState createState() => _WorkoutCreationState();
}

class _WorkoutCreationState extends State<WorkoutCreation> {
  Workout workout = Workout('', {
    fitRepExercises[0]: [ExerciseSet.repsSet(restTime: 0, reps: 0, weight: 0)]
  });

  Widget customContainer() {
    return Container(
      width: double.infinity,
      height: 60.0,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Exercise 1',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.normal)),
              SizedBox(width: 30.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 45.0),
              Text('3 Sets',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.normal)),
            ],
          ),
          Icon(Icons.close, color: Colors.white),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var workoutsProvider = Provider.of<WorkoutsManager>(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Create Workout", style: TextStyle(fontSize: 20)),
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
                    onChanged: (value) {
                      setState(() {
                        workout.name = value;
                      });
                    },
                    style:
                        TextStyle(color: const Color.fromARGB(255, 14, 13, 13)),
                    decoration: InputDecoration(
                      hintText: 'Workout name',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(179, 19, 19, 19)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 20, 20, 20)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 20, 19, 19)),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' %d Exercises'.replaceAll(
                            '%d', workout.exercises.length.toString()),
                        style: TextStyle(
                            color: const Color.fromARGB(255, 15, 14, 14),
                            fontSize: 18),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Color(0xFF39FF14)),
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
                                      (ExerciseSet set) {
                                        setState(() {
                                          workout.exercises[entry.key]!
                                              .add(set);
                                        });
                                      },
                                    ),
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
                if (widget.date != null) {
                  workoutsProvider.addPlannedWorkout(widget.date!, workout);
                } else {
                  workoutsProvider.addWorkout(workout);
                }
                Navigator.of(context).pop();
              },
              child: Text(
                'Create',
                style: TextStyle(
                    color: const Color.fromARGB(255, 6, 6, 6), fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF39FF14),
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
