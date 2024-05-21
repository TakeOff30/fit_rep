import 'package:fit_rep/components/workout_execution/reps_weight_info_section.dart';
import 'package:fit_rep/utils.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExecutionSection extends StatelessWidget {
  final bool isTimed;
  final bool isPreparationRunning;
  final double percent;
  final int exerciseTimerCounter;
  final int preparationTimerCounter;
  final bool isDarkMode;
  final int reps;
  final double weight;

  const ExecutionSection({
    required this.isTimed,
    required this.isPreparationRunning,
    required this.percent,
    required this.exerciseTimerCounter,
    required this.preparationTimerCounter,
    required this.isDarkMode,
    required this.reps,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return (isTimed)
        ? (!isPreparationRunning)
            ? CircularPercentIndicator(
                radius: 150.0,
                lineWidth: 20.0,
                percent: percent,
                center: Text(
                  formatTime(exerciseTimerCounter),
                  style: TextStyle(
                      fontSize: 40.0,
                      color: (isDarkMode) ? Colors.white : Colors.black),
                ),
                progressColor: Colors.green,
                backgroundColor: Colors.grey,
                circularStrokeCap: CircularStrokeCap.round,
              )
            : Text(
                'Get ready in $preparationTimerCounter seconds',
                style: TextStyle(fontSize: 24),
              )
        : Container(
            child: RepsAndWeightInfoSection(
              reps: reps,
              weight: weight.toInt(),
            ),
          );
  }
}
