import 'package:fit_rep/components/calendar_modal.dart';
import 'package:fit_rep/components/exercise_list_element.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/screens/workout_creation_screen.dart';
import 'package:fit_rep/screens/workout_execution_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_rep/providers/workouts_manager.dart';

class WorkoutPreviewScreen extends StatefulWidget {
  final Workout workout;

  const WorkoutPreviewScreen({required this.workout});

  @override
  _WorkoutPreviewScreenState createState() => _WorkoutPreviewScreenState();
}

class _WorkoutPreviewScreenState extends State<WorkoutPreviewScreen> {
  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this workout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Provider.of<WorkoutsManager>(context, listen: false)
                    .removeWorkout(widget.workout);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool checkShowStart() {
    //print((widget.workout as PlannedWorkout).isToday());
    if (widget.workout is CompletedWorkout) {
      return false;
    } else if (widget.workout is PlannedWorkout &&
        !(widget.workout as PlannedWorkout).isToday()) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.workout);
    return Consumer<WorkoutsManager>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.workout.name,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (String value) {
                if (value == 'edit') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutCreationScreen(
                        toModify: widget.workout,
                      ),
                    ),
                  );
                } else if (value == 'delete') {
                  _showDeleteConfirmationDialog();
                } else if (value == 'plan') {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          CalendarModal(onSelectedDate: (DateTime date) {
                            Provider.of<WorkoutsManager>(context)
                                .addPlannedWorkout(date, widget.workout);
                          }));
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                    ),
                  ),
                  if (widget.workout is! PlannedWorkout &&
                      widget.workout is! CompletedWorkout)
                    PopupMenuItem<String>(
                      value: 'plan',
                      child: ListTile(
                        leading: Icon(Icons.calendar_month),
                        title: Text('Plan'),
                      ),
                    ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Delete'),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (widget.workout is CompletedWorkout)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Burned Calories: ${(widget.workout as CompletedWorkout).burnedCalories} kcal',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'Time: ${(widget.workout as CompletedWorkout).duration.inMinutes} minutes',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    )
                  : Container(),
              Expanded(
                child: ListView(
                  children: [
                    for (var entry in widget.workout.exercises.entries)
                      ExerciseListElement(
                        exercise: entry.key,
                        sets: entry.value,
                        onTap: () {},
                        onDelete: () {},
                        canDelete: false,
                      ),
                  ],
                ),
              ),
              if (checkShowStart())
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkoutExecutionScreen(
                            workout: widget.workout,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 6, 6, 6),
                        fontSize: 20,
                      ),
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
        ),
      );
    });
  }
}
