import 'package:fit_rep/providers/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsTutorial extends StatelessWidget {
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsManager>(context);
    final PageController controller = PageController();
    return Dialog(
      backgroundColor: settingsProvider.isDarkMode
          ? Theme.of(context).primaryColorDark
          : Theme.of(context).primaryColorLight,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.all(20),
          child: PageView(
            controller: controller,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Statistics section',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text(
                    'This is where statistics will be shown and will indicate the amount of calories burned and the total workout hours of the current week and your weekly goal status. There will be displayed the total number of workouts you have ever done.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Image.asset('images/stats_tut_1.png'),
                  ElevatedButton(
                    onPressed: () {
                      controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                      iconColor: (!settingsProvider.isDarkMode)
                          ? MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColorDark)
                          : MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColorLight),
                    ),
                    child: Icon(Icons.arrow_forward),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      'Then there will be a graph that will show the calories burned by day, a ranking of the most trained workouts and a progress bar indicating your current level.',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Image.asset('images/stats_tut_2.png'),
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
            ],
          ),
        ),
      ),
    );
  }
}
