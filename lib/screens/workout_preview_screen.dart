import 'package:fit_rep/components/generics/calendar_modal.dart';
import 'package:fit_rep/components/generics/exercise_list_element.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/screens/workout_creation_screen.dart';
import 'package:fit_rep/screens/workout_execution_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:fit_rep/providers/settings_manager.dart';

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

  void _showOptionsModal() {
    final settingsProvider =
        Provider.of<SettingsManager>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: settingsProvider.isDarkMode
              ? Theme.of(context).primaryColorDark
              : Theme.of(context).primaryColorLight,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (checkShowModify())
                ListTile(
                  leading:
                      Icon(Icons.edit, color: Color.fromARGB(255, 74, 74, 74)),
                  title: Text('Edit',
                      style: TextStyle(
                          color: settingsProvider.isDarkMode
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).primaryColorDark,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .fontFamily,
                          fontSize: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .fontSize)),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutCreationScreen(
                          toModify: widget.workout,
                        ),
                      ),
                    );
                  },
                ),
              if (widget.workout is! PlannedWorkout &&
                  widget.workout is! CompletedWorkout)
                ListTile(
                  leading: Icon(Icons.calendar_month,
                      color: Color.fromARGB(255, 74, 74, 74)),
                  title: Text('Plan',
                      style: TextStyle(
                          color: settingsProvider.isDarkMode
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).primaryColorDark,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .fontFamily,
                          fontSize: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .fontSize)),
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CalendarModal(
                          onSelectedDate: (DateTime date) {
                            Provider.of<WorkoutsManager>(context, listen: false)
                                .addPlannedWorkout(date, widget.workout);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  },
                ),
              ListTile(
                leading:
                    Icon(Icons.delete, color: Color.fromARGB(255, 74, 74, 74)),
                title: Text('Delete',
                    style: TextStyle(
                        color: settingsProvider.isDarkMode
                            ? Theme.of(context).primaryColorLight
                            : Theme.of(context).primaryColorDark,
                        fontFamily:
                            Theme.of(context).textTheme.bodyMedium!.fontFamily,
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize)),
                onTap: () {
                  Navigator.of(context).pop();
                  _showDeleteConfirmationDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool checkShowStart() {
    if (widget.workout is CompletedWorkout) {
      return false;
    } else if (widget.workout is PlannedWorkout &&
        !(widget.workout as PlannedWorkout).isToday()) {
      return false;
    }

    return true;
  }

  bool checkShowModify() {
    if (widget.workout is CompletedWorkout) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsManager>(context);

    return Consumer<WorkoutsManager>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.workout.name,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: _showOptionsModal,
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/fitrep-transparent.png"),
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                opacity: 0.25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (widget.workout is CompletedWorkout)
                    ? Column(
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
          ),
        ),
      );
    });
  }
}
