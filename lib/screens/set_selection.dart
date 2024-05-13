import 'package:fit_rep/components/exercise_list_element.dart';
import 'package:fit_rep/config.dart';
import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:fit_rep/screens/exercises_selection.dart';

class SetSelection extends StatefulWidget {
  Function onUpdateSets;

  SetSelection(this.onUpdateSets);
  @override
  _SetSelectionState createState() => _SetSelectionState();
}

class _SetSelectionState extends State<SetSelection> {
  List<ExerciseSet> sets = [];
  bool isRepSet = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Selection'),
      ),
      body: 
      Padding(
        padding: EdgeInsets.all(16),
        child: 
      Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Timed'),
              Switch(
                  value: isRepSet,
                  onChanged: ((value) {
                    setState(() {
                      isRepSet = value;
                    });
                  })),
              Text('Repetitions')
            ],
          ),
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Set 1',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        print("Remove set");
                      },
                      child: Icon(Icons.close, size: 24),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 95,
                      child: TextFormField(
                        initialValue: '30',
                        decoration: InputDecoration(
                          labelText: 'Weight (Kg)',
                          border: UnderlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(
                      width: 95,
                      child: TextFormField(
                        initialValue: '1:30',
                        decoration: InputDecoration(
                          labelText: 'Rest Time (Min)',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      width: 95,
                      child: TextFormField(
                        initialValue: '15',
                        decoration: InputDecoration(
                          labelText: 'Reps',
                          border: UnderlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                )
              ],
            ),
          
          ),
        ],
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isRepSet) {
            sets.add(ExerciseSet.repsSet(restTime: 0, reps: 0, weight: 0));
          } else {
            sets.add(ExerciseSet.timedSet(restTime: 0, executionTime: 0));
          }
        },
        child: Icon(
          Icons.add,
          color: Color(0xFF1E1E1E),
        ),
        shape: CircleBorder(),
        backgroundColor: Color(0xFF39FF14),
        //backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
