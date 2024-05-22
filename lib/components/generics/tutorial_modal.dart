import 'package:flutter/material.dart';

class TutorialModal extends StatelessWidget {
  
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        child: PageView(
          children: [
            Column(
              children: [
                Text('Welcome to Fit Rep!'),
                Text('Here to make your fitness dreams come true.'),
                // logo
              ],
            ),
            Column(
              children: [
                Text('My Gym'),
                Text('This is where you can track your workouts. You can add new workouts, which will be saved and can be executed immediately, modified or planned for a specific date. The workouts planned for today will be displayed in the "Today\'s Workout" section.'),
                // image
              ],
            ),
            Column(
              children: [
                Text('Weekly statistics'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}