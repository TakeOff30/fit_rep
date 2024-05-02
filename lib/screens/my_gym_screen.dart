import 'package:fit_rep/components/filter_card.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyGymScreen extends StatefulWidget {
  MyGymScreen({Key? key}) : super(key: key);

  @override
  MyGymScreenState createState() => MyGymScreenState();
}

class MyGymScreenState extends State<MyGymScreen> {
  bool isTodayWorkout = false;
  List<Workout> toShow = [];

  @override
  Widget build(BuildContext context) {
    var workoutsProvider = Provider.of<WorkoutsManager>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child:
                Text('My Gym', style: Theme.of(context).textTheme.displayLarge),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isTodayWorkout = true;
                    toShow = workoutsProvider.getTodayWorkouts();
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    isTodayWorkout
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: const Text(
                  'Today\'s Workout',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isTodayWorkout = false;
                    toShow = workoutsProvider.workouts;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    !isTodayWorkout
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: const Text(
                  'Created workouts',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Entry A')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Entry B')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[100],
                  child: const Center(child: Text('Entry C')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
