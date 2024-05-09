import 'package:fit_rep/providers/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsManager>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Settings', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Dark Mode', style: Theme.of(context).textTheme.bodyLarge),
              Switch(
                activeColor: Theme.of(context).primaryColor,
                value: context.watch<SettingsManager>().isDarkMode,
                onChanged: (value) {
                  context.read<SettingsManager>().toggleDarkMode();
                },
              ),
            ],
          ),
          SizedBox(height: 50), 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Notifications',
                  style: Theme.of(context).textTheme.bodyLarge),
              Switch(
                activeColor: Theme.of(context).primaryColor,
                value: settingsProvider.isNotificationEnabled,
                onChanged: (value) {
                  settingsProvider.toggleNotification();
                },
              ),
            ],
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Sounds',
                  style: Theme.of(context).textTheme.bodyLarge),
              Switch(
                activeColor: Theme.of(context).primaryColor,
                value: settingsProvider.isNotificationEnabled,
                onChanged: (value) {
                  settingsProvider.toggleNotification();
                },
              ),
            ],
          ),
          SizedBox(height: 50),
          Divider(
            color: Color(0xFFC0C0C0),
            thickness: 1,
          ),
          SizedBox(height: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text('User Data',
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Height',
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: 8),
                      Container(
                        width: 75,
                        child: TextField(
                          textAlign: TextAlign.left,
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '180',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: UnderlineInputBorder(),
                            suffixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(end: 0),
                              child: Text('cm',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.right),
                            ),
                            suffixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                          ),
                          onChanged: (value) =>
                              settingsProvider.setHeight(int.parse(value)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 65),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Weight',
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: 8),
                      Container(
                        width: 75,
                        child: TextField(
                          textAlign: TextAlign.left,
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '75',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: UnderlineInputBorder(),
                            suffixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(end: 0),
                              child: Text('kg',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.right),
                            ),
                            suffixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                          ),
                          onChanged: (value) =>
                              settingsProvider.setWeight(int.parse(value)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Workouts Goal',
                  style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 75,
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: settingsProvider.weeklyWorkoutGoal,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 1,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (int? newValue) {
                      settingsProvider.setWeeklyWorkoutGoal(newValue!);
                    },
                    items: <int>[1, 2, 3, 4, 5, 6, 7]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                          alignment: Alignment.centerLeft);
                    }).toList(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
