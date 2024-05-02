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

    return Column(
      children: <Widget>[
        Text('Settings', style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 16),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Dark Mode',
                  style: Theme.of(context).textTheme.displayMedium),
              Switch(
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Notifications',
                  style: Theme.of(context).textTheme.displayMedium),
              Switch(
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
              Text('Weight', style: Theme.of(context).textTheme.displayMedium),
              Expanded(
                  child: TextField(
                decoration: const InputDecoration(
                  hintText: '70',
                ),
                onChanged: (value) =>
                    settingsProvider.setWeight(int.parse(value)),
              ))
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Height', style: Theme.of(context).textTheme.displayMedium),
              Expanded(
                  child: TextField(
                decoration: const InputDecoration(
                  hintText: '180',
                ),
                onChanged: (value) =>
                    settingsProvider.setHeight(int.parse(value)),
              ))
            ],
          ),
        )
      ],
    );
  }
}
