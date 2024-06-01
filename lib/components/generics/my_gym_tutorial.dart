import 'package:fit_rep/providers/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyGymTutorial extends StatelessWidget {
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
              Text('MyGym section',
                  style: Theme.of(context).textTheme.headlineMedium),
              Text(
                'This is where you can manage the workouts you created. You can see the details of the workout by clicking on it. You can see the workouts scheduled for today by clicking the "Today\'s workouts" button on the top left corner.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'You can also add a new workout by clicking on the + button. It will be scheduled for today if "Today\'s workouts" is selected, otherwise it will be added to the list of general workouts.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Got it!',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor))),
            ],
          ),
        ),
      ),
    );
  }
}
