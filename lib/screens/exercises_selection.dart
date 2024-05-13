import 'package:flutter/material.dart';
import 'package:fit_rep/config.dart';
import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/enums.dart';

class Filter {
  String exerciseNameFilter = '';
  String musclesFilter = '';

  Filter(this.exerciseNameFilter, this.musclesFilter);

  List<Exercise> filterExercises(List<Exercise> exercises) {
    return exercises.where((exercise) {
      if (exerciseNameFilter != '' &&
          !exercise.name
              .toLowerCase()
              .contains(exerciseNameFilter.toLowerCase())) {
        return false;
      }
      if (musclesFilter != '' &&
          !(exercise.primaryMuscle.name == musclesFilter.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();
  }
}

class ExercisesSelection extends StatefulWidget {
  Function addExercises;

  ExercisesSelection(this.addExercises);

  

  @override
  _ExercisesSelectionState createState() => _ExercisesSelectionState();
}

class _ExercisesSelectionState extends State<ExercisesSelection> {
  final Filter filters = Filter('', '');
  List<Exercise> filteredExercises = fitRepExercises;
  int _selectedIndex = -1;
  String? selectedMuscle; // Variable to keep track of the selected muscle
  final List<String> muscles = Muscle.values
      .map((e) => e.name.toLowerCase())
      .toList(); // Example list of muscles

  void updateExercises() {
    List<Exercise> toShow = fitRepExercises;
    setState(() {
      filteredExercises = filters.filterExercises(toShow);
    });
  }

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
                        contentPadding: EdgeInsets.all(8.0),
                        isDense: true,
                      ),
                      onChanged: (value) {
                        setState(() {
                          filters.exerciseNameFilter = value;
                          updateExercises();
                        });
                      },
                    ),
                  ),
                  Icon(Icons.search),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 40.0, // Set a fixed height for the chips container
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: muscles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(muscles[index]),
                      selected: selectedMuscle == muscles[index],
                      onSelected: (bool selected) {
                        setState(() {
                          if (selectedMuscle == muscles[index]) {
                            selectedMuscle = null;
                            filters.musclesFilter = '';
                          } else if (selected) {
                            selectedMuscle = muscles[index];
                            filters.musclesFilter = muscles[index];
                          }
                          updateExercises();
                        });
                      },
                      backgroundColor: Colors.grey[300],
                      selectedColor: Colors.blue,
                      labelStyle: TextStyle(
                          color: selectedMuscle == muscles[index]
                              ? Colors.white
                              : Colors.black),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredExercises.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(filteredExercises[index].name),
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
                  widget.addExercises(filteredExercises[_selectedIndex]);
                  Navigator.pop(context);
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
