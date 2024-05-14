import 'package:fit_rep/models/exercise_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';

class SetCard extends StatefulWidget {
  ExerciseSet exeSet;
  Function onUpdateSet;
  Function onRemoveSet;
  int setNumber;

  SetCard(this.exeSet, this.onUpdateSet, this.onRemoveSet, this.setNumber);

  SetCardState createState() => SetCardState();
}

class SetCardState extends State<SetCard> {
  TextEditingController restTimeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController executionTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    restTimeController = TextEditingController(
        text:
            "${widget.exeSet.restTime.inMinutes.toString().padLeft(2, '0')}:${(widget.exeSet.restTime.inSeconds.remainder(60)).toString().padLeft(2, '0')}");
    weightController =
        TextEditingController(text: widget.exeSet.weight.toString());
    repsController = TextEditingController(text: widget.exeSet.reps.toString());
    executionTimeController = TextEditingController(
        text:
            "${widget.exeSet.executionTime.inMinutes.toString().padLeft(2, '0')}:${(widget.exeSet.executionTime.inSeconds.remainder(60)).toString().padLeft(2, '0')}");
  }

  @override
  void dispose() {
    restTimeController.dispose();
    weightController.dispose();
    repsController.dispose();
    executionTimeController.dispose();
    super.dispose();
  }

  Widget build(context) {
    return Builder(builder: (context) {
      return Container(
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
                Text('Set ' + widget.setNumber.toString(),
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    widget.onRemoveSet();
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
                    controller: weightController,
                    onChanged: (value) {
                      widget.exeSet.weight = int.parse(value);
                      widget.onUpdateSet(widget.exeSet);
                    },
                    decoration: InputDecoration(
                      labelText: 'Weight (Kg)',
                      hintText: '50',
                      border: UnderlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  width: 95,
                  child: TextFormField(
                    controller: restTimeController,
                    onTap: () {
                      showPickerDuration(context, (Duration duration) {
                        setState(() {
                          widget.exeSet.restTime = duration;
                          restTimeController.text =
                              "${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}";
                          widget.onUpdateSet(widget.exeSet);
                        });
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Rest Time (Min)',
                      hintText: '1:30',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
                (widget.exeSet.isTimed)
                    ? Container(
                        width: 95,
                        child: TextFormField(
                          controller: executionTimeController,
                          onTap: () {
                            showPickerDuration(context, (Duration duration) {
                              setState(() {
                                widget.exeSet.restTime = duration;
                                executionTimeController.text =
                                    "${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}";
                                widget.onUpdateSet(widget.exeSet);
                              });
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Execution Time (Min)',
                            hintText: '1:30',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      )
                    : Container(
                        width: 95,
                        child: TextFormField(
                          controller: repsController,
                          onChanged: (value) {
                            widget.exeSet.reps = int.parse(value);
                            widget.onUpdateSet(widget.exeSet);
                          },
                          decoration: InputDecoration(
                            labelText: 'Reps',
                            hintText: '10',
                            border: UnderlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
              ],
            )
          ],
        ),
      );
    });
  }

  void showPickerDuration(BuildContext context, Function onConfirm) {
    print('showed');
    Duration duration = Duration(minutes: 0, seconds: 0);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          content: Container(
            height: 300,
            child: Column(
              children: [
                Expanded(
                  child: Picker(
                    adapter: NumberPickerAdapter(data: [
                      NumberPickerColumn(
                          begin: 0, end: 2, suffix: Text("m")), // minutes
                      NumberPickerColumn(
                          begin: 0, end: 59, suffix: Text("s")), // seconds
                    ]),
                    delimiter: [
                      PickerDelimiter(
                          column: 1,
                          child: Container(
                            width: 16.0,
                            alignment: Alignment.center,
                            child: Text(':',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            color: Colors.white,
                          )),
                    ],
                    title: Text("Select duration"),
                    selectedTextStyle: TextStyle(color: Colors.blue),
                    onConfirm: (Picker picker, List value) {
                      onConfirm(duration);
                    },
                    onSelect: (Picker picker, int index, List<int> selected) {
                      setState(() {
                        duration = Duration(
                          minutes: picker.getSelectedValues()[0],
                          seconds: picker.getSelectedValues()[1],
                        );
                      });
                    },
                  ).makePicker(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
