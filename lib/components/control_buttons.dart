import 'package:fit_rep/providers/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlButtons extends StatelessWidget {
  final Function togglePlayPause;
  final Function nextSetOrExercise;
  final bool isRunningGlobal;

  const ControlButtons({
    required this.togglePlayPause,
    required this.nextSetOrExercise,
    required this.isRunningGlobal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 250,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
            color: (Provider.of<SettingsManager>(context).isDarkMode)
                ? Colors.white
                : Colors.black,
            width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: () {
              togglePlayPause();
            },
            child: Icon((isRunningGlobal) ? Icons.pause : Icons.play_arrow,
                color: Colors.green, size: 40),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          FloatingActionButton(
            onPressed: () {
              nextSetOrExercise();
            },
            child: Icon(Icons.check, color: Colors.green, size: 40),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ],
      ),
    );
  }
}
