import 'package:fit_rep/enums.dart';
import 'package:fit_rep/providers/settings_manager.dart';
import 'package:fit_rep/providers/statistics_manager.dart';
import 'package:flutter/material.dart';
import 'package:fit_rep/components/weekly_kcal_bar_charth.dart';
import 'package:fit_rep/components/level_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIcon = 3; // Default selection for "Weekly kcal"
  int? selectedBarIndex; // Variable to keep track of the selected bar

  List<Muscle> mostTrainedMuscles() {
    var statisticsProvider = Provider.of<StatisticsManager>(context);
    var muscles = statisticsProvider.trainedMuscles;
    var mostTrainedMuscles = muscles.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return mostTrainedMuscles.map((e) => e.key).toList();
  }

  @override
  Widget build(BuildContext context) {
    var _statisticsProvider = Provider.of<StatisticsManager>(context);
    var _settingsProvider = Provider.of<SettingsManager>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Text(
                  'Weekly Statistics',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: Container(
                  // Container for the statistics
                  width: 300,
                  height: 260,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFC0C0C0), width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            _buildIconSection(
                                Icons.emoji_events,
                                _statisticsProvider.workoutsCompleted
                                    .toString(),
                                true,
                                true),
                            _buildIconSection(
                                Icons.fitness_center,
                                '${_statisticsProvider.totalWeeklyWorkoutsCompleted}/${_settingsProvider.weeklyWorkoutGoal}',
                                false,
                                true),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            _buildIconSection(
                                Icons.local_fire_department,
                                '${_statisticsProvider.weeklyCalories.values.reduce((value, element) => value + element)} kcal',
                                true,
                                false),
                            _buildIconSection(
                                Icons.timer,
                                '${_statisticsProvider.totalWorkoutDuration.inHours} hours',
                                false,
                                false),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _buildIconRow(),
              const SizedBox(height: 20),
              if (_selectedIcon == 3)
                Column(
                  children: <Widget>[
                    Text(
                      'Burned calories per day',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Display bar chart if "Weekly kcal" is selected
                    WeeklyKcalChart(
                      selectedBarIndex: selectedBarIndex ?? 0,
                      onBarTap: (int index) {
                        setState(() {
                          selectedBarIndex = index;
                        });
                      },
                    ),
                  ],
                ),
              if (_selectedIcon == 2)
                // Display muscles names if "Muscles" is selected
                Column(children: [
                  Text(
                    'Latest most trained muscles',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...mostTrainedMuscles()
                      .take(3)
                      .toList()
                      .asMap()
                      .entries
                      .map((entry) => Column(
                            children: [
                              Text(
                                '${entry.key + 1}. ${entry.value.name}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              SizedBox(height: 20), // Add vertical space
                            ],
                          ))
                      .toList(), // Add vertical space
                ]),
              if (_selectedIcon == 1)
                XPGradientProgressBar(
                  level: _statisticsProvider.userLevel,
                  currentXP: _statisticsProvider.currentXP,
                  maxXP: _statisticsProvider.totalXPToLevelUp,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Build the row of 3 icons
  Widget _buildIconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _iconButton(3, Icons.local_fire_department, 'Weekly kcal'),
        _iconButton(1, Icons.trending_up, 'Level'),
        _iconButton(2, Icons.fitness_center, 'Muscles'),
      ],
    );
  }

  // Build the icon button
  Widget _iconButton(int id, IconData icon, String label) {
    bool isSelected = _selectedIcon == id;
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(icon, size: 40),
          color: isSelected
              ? Theme.of(context).primaryColor
              : const Color(0xFFC0C0C0),
          onPressed: () {
            setState(() {
              _selectedIcon = _selectedIcon == id ? 0 : id;
            });
          },
        ),
        if (isSelected)
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
      ],
    );
  }

  // Build the icon section
  Widget _buildIconSection(
      IconData icon, String label, bool borderRight, bool borderBottom) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: borderRight
                ? const BorderSide(width: 2, color: Color(0xFFC0C0C0))
                : BorderSide.none,
            bottom: borderBottom
                ? const BorderSide(width: 2, color: Color(0xFFC0C0C0))
                : BorderSide.none,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 32, color: Theme.of(context).primaryColor),
              const SizedBox(height: 8),
              Text(label,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto')),
            ],
          ),
        ),
      ),
    );
  }
}
