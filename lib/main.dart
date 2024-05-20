import 'package:fit_rep/providers/settings_manager.dart';
import 'package:fit_rep/providers/statistics_manager.dart';
import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:fit_rep/screens/home_screen.dart';
import 'package:fit_rep/screens/my_gym_screen.dart';
import 'package:fit_rep/screens/calendar_screen.dart';
import 'package:fit_rep/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_rep/init.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FitRepApp());
}

class FitRepApp extends StatefulWidget {
  const FitRepApp({Key? key}) : super(key: key);

  @override
  _FitRepAppState createState() => _FitRepAppState();
}

class _FitRepAppState extends State<FitRepApp> {
  final WorkoutsManager _workoutsManager = WorkoutsManager();
  final SettingsManager _settingsManager = SettingsManager();
  final StatisticsManager _statisticsManager = StatisticsManager();

  @override
  void initState() {
    super.initState();
    //init();
  }

  int _selectedIndex = 0;
  final List<Widget> destinations = <Widget>[
    MyGymScreen(),
    HomeScreen(),
    CalendarScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => _workoutsManager),
          ChangeNotifierProvider(create: (context) => _settingsManager),
          ChangeNotifierProvider(create: (context) => _statisticsManager),
        ],
        child: Consumer<SettingsManager>(
            builder: (context, settingsManger, child) {
          return MaterialApp(
            title: 'Fit Rep',
            theme: _settingsManager.theme,
            home: Scaffold(
              body: SafeArea(
                  child: IndexedStack(
                index: _selectedIndex,
                children: destinations,
              )),
              bottomNavigationBar: NavigationBar(
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                onDestinationSelected: _onItemTapped,
                selectedIndex: _selectedIndex,
                indicatorShape: CircleBorder(),
                destinations: <NavigationDestination>[
                  NavigationDestination(
                    icon: _selectedIndex == 0
                        ? Icon(Icons.fitness_center,
                            color: settingsManger.theme.primaryColor)
                        : Icon(Icons.fitness_center),
                    label: 'Create Workout',
                  ),
                  NavigationDestination(
                    icon: _selectedIndex == 1
                        ? Icon(Icons.home,
                            color: settingsManger.theme.primaryColor)
                        : Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: _selectedIndex == 2
                        ? Icon(Icons.calendar_month,
                            color: settingsManger.theme.primaryColor)
                        : Icon(Icons.calendar_month),
                    label: 'Calendar',
                  ),
                  NavigationDestination(
                    icon: _selectedIndex == 3
                        ? Icon(Icons.settings,
                            color: settingsManger.theme.primaryColor)
                        : Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
