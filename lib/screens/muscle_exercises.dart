import 'package:flutter/material.dart';

class MuscleExercises extends StatefulWidget {
  final String muscle;

  MuscleExercises({required this.muscle});

  @override
  _MuscleExercisesState createState() => _MuscleExercisesState();
}

class _MuscleExercisesState extends State<MuscleExercises> {
  List<String> exercises = [];
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    // Fetch exercises for the selected muscle
    // This is just a placeholder, replace with your actual logic
    exercises = [
      'Exercise 1 for ${widget.muscle}',
      'Exercise 2 for ${widget.muscle}',
      'Exercise 3 for ${widget.muscle}'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.muscle} Exercises', // Use the selected muscle in the title
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
            Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(exercises[index]),
                        trailing:
                            _selectedIndex == index ? Icon(Icons.check) : null,
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 1,
                      ),
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
