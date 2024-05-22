import 'package:flutter/material.dart';

class WelcomeModal extends StatelessWidget {
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Welcome to Fit Rep!'),
            Text('Here to make your fitness dreams come true.'),
            Text(
                'This is where you can track your workouts, plan your exercises, see your progress: Fit Rep will be your best friend in your fitness journey.'),
          ],
        ),
      ),
    );
  }
}
