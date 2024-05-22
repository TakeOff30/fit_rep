import 'package:fit_rep/components/statistics/level_bar.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/providers/statistics_manager.dart';
import 'package:fit_rep/utils.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class WorkoutTerminationScreen extends StatelessWidget {
  CompletedWorkout completedWorkout;
  final onLoadPlayer = AudioPlayer();

  Future<void> setupAudio() async {
    await onLoadPlayer.setUrl('asset:assets/sounds/done.mp3');
    onLoadPlayer.play();
  }

  WorkoutTerminationScreen({required this.completedWorkout});
  @override
  Widget build(BuildContext context) {
    var statisticsProvider = Provider.of<StatisticsManager>(context);
    return FutureBuilder(
        future: setupAudio(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading spinner while waiting
          } else {
            return Scaffold(
                appBar: AppBar(
                    title: Text('Workout Terminated!',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ))),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('You did an amazing job!',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kanit',
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Here are your stats:',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                )),
                            Text(
                              'Total time: ${formatTime(completedWorkout.duration.inSeconds)}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Total calories burned: ${completedWorkout.burnedCalories}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Total XP earned: ${completedWorkout.calculateXP()}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        XPGradientProgressBar(
                          level: statisticsProvider.userLevel,
                          currentXP: statisticsProvider.currentXP,
                          maxXP: statisticsProvider.totalXPToLevelUp,
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.check,
                    color: Color(0xFF1E1E1E),
                  ),
                  shape: CircleBorder(),
                  backgroundColor: Theme.of(context).primaryColor,
                ));
          }
        });
  }
}
