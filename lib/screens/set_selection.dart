import 'package:fit_rep/components/generics/exercise_list_element.dart';
import 'package:fit_rep/components/generics/set_card.dart';
import 'package:fit_rep/config.dart';
import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/models/exercise_set.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:fit_rep/screens/exercises_selection.dart';
import 'package:flutter_picker/flutter_picker.dart';

class SetSelection extends StatefulWidget {
  List<ExerciseSet> sets;
  Function onAddSets;

  SetSelection(this.sets, this.onAddSets);
  @override
  _SetSelectionState createState() => _SetSelectionState();
}

class _SetSelectionState extends State<SetSelection> {
  bool isRepSet = true;

  Map<ExerciseSet, List<TextEditingController>> controllers = {};

  @override
  void initState() {
    super.initState();
    widget.sets.map((e) {
      if (e.isTimed) {
        controllers[e] = [
          TextEditingController(text: e.executionTime.inMinutes.toString()),
          TextEditingController(text: e.restTime.inMinutes.toString()),
          TextEditingController(text: e.weight.toString()),
        ];
      } else {
        controllers[e] = [
          TextEditingController(text: e.reps.toString()),
          TextEditingController(text: e.restTime.inMinutes.toString()),
          TextEditingController(text: e.weight.toString()),
        ];
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controllers.forEach((key, value) {
      for (var element in value) {
        element.dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Selection'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
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
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' %d Sets'.replaceAll('%d', widget.sets.length.toString()),
                  style: TextStyle(
                      color: const Color.fromARGB(255, 15, 14, 14),
                      fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Color(0xFF39FF14)),
                  iconSize: 48,
                  onPressed: () {
                    setState(() {
                      if (isRepSet) {
                        widget.sets.add(ExerciseSet.repsSet(
                            restTime: Duration(minutes: 0, seconds: 10),
                            reps: 0,
                            weight: 0));
                      } else {
                        widget.sets.add(ExerciseSet.timedSet(
                            restTime: Duration(minutes: 0, seconds: 10),
                            executionTime: Duration(minutes: 0, seconds: 0),
                            weight: 0));
                      }
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 50),
            Builder(builder: (context) {
              return Column(
                children: [
                  ...widget.sets.asMap().entries.map((entry) {
                    int index = entry.key;
                    ExerciseSet exeSet = entry.value;

                    return SetCard(exeSet, (newSet) {
                      setState(() {
                        widget.sets[index] = newSet;
                      });
                    }, () {
                      setState(() {
                        widget.sets.removeAt(index);
                      });
                    }, index + 1);
                  }).toList()
                ],
              );
            })
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: ElevatedButton(
          onPressed: () {
            widget.onAddSets(widget.sets);
            Navigator.pop(context);
          },
          child: Text(
            'Save',
            style: TextStyle(
                color: const Color.fromARGB(255, 6, 6, 6), fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF39FF14),
            fixedSize: Size(170, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
