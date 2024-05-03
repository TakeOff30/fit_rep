import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/providers/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;

  const WorkoutCard({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsManager>(context, listen: false);

    return Container(
      width: double.infinity,
      height: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: settingsProvider.isDarkMode
                ? Theme.of(context).primaryColorLight
                : Theme.of(context).primaryColorDark,
            width: 1),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            workout.name,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 10), // Spazio tra titolo e contenuti
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Type: ${workout.exerciseTypes().join(', ')}',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Exercises: ${workout.exercises.length}',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Kcal: ${workout.calculateCaloriesBurned(settingsProvider.weight).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Xp: ${workout.calculateXP()}',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          //Navigator.of(context).pushNamed('/workout',
                          //    arguments: {'workout': workout});
                        },
                        icon: Icon(Icons.play_arrow,
                            color: Color(0xFF39FF14), size: 32)),
                    IconButton(
                        onPressed: () {
                          //Navigator.of(context).pushNamed('/calendar');
                        },
                        icon: Icon(Icons.calendar_today, size: 32)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
