import 'package:flutter/material.dart';

class RepsAndWeightInfoSection extends StatelessWidget {
  final int reps;
  final int weight;

  const RepsAndWeightInfoSection({
    required this.reps,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              'Reps',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              reps.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'Weight',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              weight.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ],
    );
  }
}
