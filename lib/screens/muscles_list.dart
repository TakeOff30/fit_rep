import 'package:flutter/material.dart';
import 'package:fit_rep/screens/exercises_selection.dart';
import 'package:fit_rep/screens/muscle_exercises.dart';

class MusclesList extends StatefulWidget {
  @override
  _MusclesListState createState() => _MusclesListState();
}

class _MusclesListState extends State<MusclesList> {
  List<String> muscles = ['Muscle 1', 'Muscle 2', 'Muscle 3'];
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Muscles List',
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
                        contentPadding: EdgeInsets.all(8.0),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExercisesSelection(),
                      ),
                    );
                  },
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
                ElevatedButton(
                  //redirect to muscles_list.dart
                  onPressed: () {},
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
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: muscles.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(muscles[index]),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MuscleExercises(muscle: muscles[index])),
                          );
                        },
                      ),
                      Divider(height: 1),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
