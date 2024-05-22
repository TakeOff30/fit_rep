// Level xp bar

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LevelBar extends StatelessWidget {
  final int level;
  final int currentXP;
  final int maxXP;

  LevelBar({
    Key? key,
    required this.level,
    required this.currentXP,
    required this.maxXP,
  }) : super(key: key);

  double get progress => currentXP / maxXP;

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.primaryColor.withOpacity(1.0),
          AppColors.primaryColor.withOpacity(0.4)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('LV. $level',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.normal,
                  )),
              Text('$currentXP/$maxXP XP',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.normal,
                  )),
            ],
          ),
        ),
        Container(
          height: 20,
          width: double.infinity,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color:
                Color(0xFFD9D9D9), // Background color for the uncompleted part
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                gradient: _barsGradient,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppColors {
  static Color primaryColor = Color(0xFF39FF14); // Bright green color
}
