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
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Dark Mode', style: Theme.of(context).textTheme.bodyLarge),
                Switch(
                  activeColor: Theme.of(context).primaryColor,
                  value: context.watch<SettingsManager>().isDarkMode,
                  onChanged: (value) {
                    context.read<SettingsManager>().toggleDarkMode();
                    print(context.read<SettingsManager>().isDarkMode);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
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
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Height',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
                TextField(
                  textAlign: TextAlign.right,
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      constraints: BoxConstraints(maxWidth: 80),
                      hintText: '180',
                      hintStyle: TextStyle(color: Colors.grey)),
                  onChanged: (value) =>
                      settingsProvider.setHeight(int.parse(value)),
                ),
                Text('cm',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Weight',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
                TextField(
                  textAlign: TextAlign.right,
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      constraints: BoxConstraints(maxWidth: 80),
                      hintText: '70',
                      hintStyle: TextStyle(color: Colors.grey)),
                  onChanged: (value) =>
                      settingsProvider.setWeight(int.parse(value)),
                ),
                Text('kg',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          )
        ],
      ),
    );
  }
}
