import 'package:fit_rep/components/filter_card.dart';
import 'package:fit_rep/components/workout_card.dart';
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
  bool isTodayWorkout =
      false; // Questa variabile dovrebbe controllare quale set di workout mostrare
  Filter filters = Filter('', [], '', []);
  List<Workout> filteredWorkouts = [];

  void updateWorkouts() {}

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsManager>(context);

    updateWorkouts();
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text('My Gym',
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isTodayWorkout = true;
                        updateWorkouts();
                        List<Workout> toShow = [];
                        if (isTodayWorkout) {
                          toShow = workoutsManager.getWorkoutsByDay(
                              DateTime.now()); // Ottiene i workout di oggi
                        } else {
                          toShow = workoutsManager
                              .getCreatedWorkouts(); // Ottiene i workout creati
                        }
                        filteredWorkouts = filters.filterWorkouts(toShow);
                        print(
                            "Filtered workouts count: ${filteredWorkouts.length}");
                        filteredWorkouts.forEach((workout) => print(workout
                            .name)); // Assumendo che ci sia un attributo 'name'
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
                        updateWorkouts();
                        List<Workout> toShow = [];
                        if (isTodayWorkout) {
                          toShow = workoutsManager.getWorkoutsByDay(
                              DateTime.now()); // Ottiene i workout di oggi
                        } else {
                          toShow = workoutsManager
                              .getCreatedWorkouts(); // Ottiene i workout creati
                        }
                        filteredWorkouts = filters.filterWorkouts(toShow);
                        print(
                            "Filtered workouts count: ${filteredWorkouts.length}");
                        filteredWorkouts.forEach((workout) => print(workout
                            .name)); // Assumendo che ci sia un attributo 'name'
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
                    updateWorkouts();
                  });
                },
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: filteredWorkouts.map(
                    (workout) {
                      return WorkoutCard(workout: workout);
                    },
                  ).toList(),
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
          backgroundColor: Color(0xFF39FF14),
          //backgroundColor: Colors.green,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
