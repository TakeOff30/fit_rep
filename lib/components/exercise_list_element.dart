import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:flutter/material.dart';

class ExerciseListElement extends StatelessWidget {
  final Exercise exercise;
  final Function onTap;
  final Function onDelete;

  final List<ExerciseSet> sets;

  ExerciseListElement(
      {required this.exercise,
      required this.sets,
      required this.onTap,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(exercise.name,
              style: TextStyle(fontSize: 16, fontFamily: "Roboto")),
              width: MediaQuery.of(context).size.width * 0.3,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
          Text(sets.length.toString() + " Sets", textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.normal)),
          IconButton(
            alignment: Alignment.center,
            icon: Icon(Icons.close),
            onPressed: () => onDelete(exercise),
          )
        ],
      ),
      )
      
      
    );
  }
}
