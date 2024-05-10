import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:flutter/material.dart';

class ExerciseListElement extends StatelessWidget {
  final Exercise exercise;
  final Function onTap;
  final List<ExerciseSet> sets;

  ExerciseListElement(
      {required this.exercise, required this.sets, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(exercise.name,
                  style: TextStyle(fontSize: 16, fontFamily: "Roboto")),
              SizedBox(width: 30.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 45.0),
              Text(sets.length.toString() + " Sets",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.normal)),
            ],
          ),
          Icon(Icons.close),
        ],
      ),
    );
  }
}
