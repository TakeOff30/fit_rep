import 'package:fit_rep/models/exercise_set.dart';
import 'package:flutter/material.dart';

class SetCard extends StatefulWidget {
  ExerciseSet exeSet;
  Function onUpdateSet;
  int setNumber;
  Function onRemoveSet;

  SetCard(this.exeSet, this.onUpdateSet, this.onRemoveSet, this.setNumber);

  SetCardState createState() => SetCardState();
}

class SetCardState extends State<SetCard> {
  Widget build(context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Set %d'.replaceAll('%d', widget.setNumber.toString()),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(
                onPressed: () {
                  widget.onRemoveSet();
                },
                icon: Icon(Icons.close, size: 24))
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 95,
              child: TextFormField(
                onChanged: (value) {
                  widget.exeSet.weight = int.parse(value);
                },
                decoration: InputDecoration(
                  hintText: '30',
                  labelText: 'Weight (Kg)',
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter reps';
                  }
                  return null;
                },
              ),
            ),
            Container(
              width: 95,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: '1:30',
                  labelText: 'Rest Time (Min)',
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rest time';
                  }
                  return null;
                },
              ),
            ),
            Container(
              width: 95,
              child: TextFormField(
                onChanged: (value) {
                    widget.exeSet.reps = int.parse(value);
                },
                decoration: InputDecoration(
                  hintText: '15',
                  labelText: 'Reps',
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter reps';
                  }
                  return null;
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
