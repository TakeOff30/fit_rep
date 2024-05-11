import 'package:flutter/material.dart';
import 'package:fit_rep/screens/muscles_list.dart';
import 'package:fit_rep/config.dart';
import 'package:fit_rep/models/exercise.dart';

class ExercisesSelection extends StatefulWidget {
  @override
  _ExercisesSelectionState createState() => _ExercisesSelectionState();
}

class _ExercisesSelectionState extends State<ExercisesSelection> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exercises List',
          style: TextStyle(
              fontFamily: 'Roboto', fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.all(8.0), 
                        isDense:
                            true, // remove the default padding of the TextField
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Implement your search functionality here
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  child: Text('All'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150, 36),
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                ElevatedButton( //redirect to muscles_list.dart
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MusclesList()),
                    );
                  },
                  child: Text('By Muscle'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150, 36),
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: fitRepExercises.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(fitRepExercises[index].name),
                        trailing:
                            _selectedIndex == index ? Icon(Icons.check) : null,
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      ),
                      Divider(height: 1),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Button action here
                },
                child: Text(
                  'Select',
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
          ],
        ),
      ),
    );
  }
}
