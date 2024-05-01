import 'package:fit_rep/providers/settings_manager.dart';
import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:fit_rep/screens/home_screen.dart';
import 'package:fit_rep/screens/my_gym_screen.dart';
import 'package:fit_rep/screens/calendar_screen.dart';
import 'package:fit_rep/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  onTap: _onItemTapped,
                  currentIndex: _selectedIndex,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.fitness_center),
                      label: 'Create Workout',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_month),
                      label: 'Calendar',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
