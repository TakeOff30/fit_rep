import 'package:fit_rep/components/generics/filter_card.dart';
import 'package:fit_rep/components/generics/my_gym_tutorial.dart';
import 'package:fit_rep/components/generics/workout_card.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/providers/settings_manager.dart';
import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_rep/screens/workout_creation_screen.dart';
import 'package:fit_rep/config.dart';

class MyGymScreen extends StatefulWidget {
  MyGymScreen({Key? key}) : super(key: key);

  @override
  MyGymScreenState createState() => MyGymScreenState();
}

class MyGymScreenState extends State<MyGymScreen> {
  bool isTodayWorkout = false;
  Filter filters = Filter('', [], '', []);
  List<Workout> filteredWorkouts = [];

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsManager>(context);

    return Consumer<WorkoutsManager>(
        builder: (context, workoutsManager, child) {
      List<Workout> toShow = [];
      if (isTodayWorkout) {
        toShow = workoutsManager
            .getWorkoutsByDay(DateTime.now()); // Ottiene i workout di oggi
      } else {
        toShow =
            workoutsManager.getCreatedWorkouts(); // Ottiene i workout creati
      }
      filteredWorkouts = filters.filterWorkouts(toShow);
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('My Gym',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Kanit',
              )),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info,
                color: settingsProvider.isDarkMode
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                showDialog(
                    context: context, builder: (context) => MyGymTutorial());
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isTodayWorkout = true;
                        List<Workout> toShow = [];
                        if (isTodayWorkout) {
                          toShow = workoutsManager.getWorkoutsByDay(
                              DateTime.now()); // Ottiene i workout di oggi
                        } else {
                          toShow = workoutsManager
                              .getCreatedWorkouts(); // Ottiene i workout creati
                        }
                        filteredWorkouts = filters.filterWorkouts(toShow);
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        isTodayWorkout
                            ? Theme.of(context).primaryColor
                            : settingsProvider.isDarkMode
                                ? Theme.of(context).primaryColorDark
                                : Theme.of(context).primaryColorLight,
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                            width: 1,
                            color: settingsProvider.isDarkMode
                                ? Theme.of(context).primaryColorLight
                                : Theme.of(context).primaryColorDark),
                      ),
                    ),
                    child: Text(
                      'Today\'s Workout',
                      style: TextStyle(
                        color:
                            settingsProvider.theme.textTheme.bodyLarge!.color,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isTodayWorkout = false;
                        List<Workout> toShow = [];
                        if (isTodayWorkout) {
                          toShow = workoutsManager.getWorkoutsByDay(
                              DateTime.now()); // Ottiene i workout di oggi
                        } else {
                          toShow = workoutsManager
                              .getCreatedWorkouts(); // Ottiene i workout creati
                        }
                        filteredWorkouts = filters.filterWorkouts(toShow);
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        !isTodayWorkout
                            ? Theme.of(context).primaryColor
                            : settingsProvider.isDarkMode
                                ? Theme.of(context).primaryColorDark
                                : Theme.of(context).primaryColorLight,
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                            color: settingsProvider.isDarkMode
                                ? Theme.of(context).primaryColorLight
                                : Theme.of(context).primaryColorDark,
                            width: 1),
                      ),
                    ),
                    child: Text(
                      'Created workouts',
                      style: TextStyle(
                        color:
                            settingsProvider.theme.textTheme.bodyLarge!.color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FilterCard(
                filters,
                (newFilter) {
                  setState(() {
                    filters = newFilter;
                    List<Workout> toShow = [];
                    if (isTodayWorkout) {
                      toShow = workoutsManager.getWorkoutsByDay(
                          DateTime.now()); // Ottiene i workout di oggi
                    } else {
                      toShow = workoutsManager
                          .getCreatedWorkouts(); // Ottiene i workout creati
                    }
                    filteredWorkouts = filters.filterWorkouts(toShow);
                  });
                },
              ),
              (filteredWorkouts.isNotEmpty)
                  ? Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: filteredWorkouts.map(
                          (workout) {
                            return WorkoutCard(workout: workout);
                          },
                        ).toList(),
                      ),
                    )
                  : (toShow.isNotEmpty)
                      ? Expanded(
                          child: Center(
                            child: Text(
                              'No workouts corresponding to the filters',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: Text(
                              'No workouts available',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (isTodayWorkout)
                      ? WorkoutCreationScreen(date: DateTime.now())
                      : WorkoutCreationScreen()),
            );
          },
          child: Icon(
            Icons.add,
            color: Color(0xFF1E1E1E),
          ),
          shape: CircleBorder(),
          backgroundColor: Theme.of(context).primaryColor,
          //backgroundColor: Colors.green,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
