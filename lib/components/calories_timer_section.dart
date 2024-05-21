import 'package:fit_rep/providers/settings_manager.dart';
import 'package:fit_rep/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaloriesTimerSection extends StatelessWidget {
  int globalTimerCounter;
  int caloriesBurned;

  CaloriesTimerSection(
      {required this.globalTimerCounter, required this.caloriesBurned});

  @override
  Widget build(BuildContext context) {
    var settingsManager = Provider.of<SettingsManager>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width * .4,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (settingsManager.isDarkMode) ? Colors.white : Colors.black,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              'Burned: $caloriesBurned kcal',
              style: TextStyle(
                  color: (settingsManager.isDarkMode)
                      ? Colors.white
                      : Colors.black,
                  fontSize: 16),
            ),
          ),
        ),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width * .4,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (settingsManager.isDarkMode) ? Colors.white : Colors.black,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              'Total time:${formatTime(globalTimerCounter)}',
              style: TextStyle(
                  color: (settingsManager.isDarkMode)
                      ? Colors.white
                      : Colors.black,
                  fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
