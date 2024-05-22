import 'package:fit_rep/providers/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarTutorial extends StatelessWidget {
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsManager>(context);
    return Dialog(
      backgroundColor: settingsProvider.isDarkMode
          ? Theme.of(context).primaryColorDark
          : Theme.of(context).primaryColorLight,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Calendar section',
                  style: Theme.of(context).textTheme.headlineMedium),
              Text(
                'This is where you can plan your workouts and view the workouts you did in the past. The busy days will be highlighted in the calendar, and you can see the details of the workout by clicking on the day.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Image.asset('images/calendar_tut_1.png'),
            ],
          ),
        ),
      ),
    );
  }
}
