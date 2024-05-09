import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_rep/providers/workouts_manager.dart';

class WorkoutCreation extends StatefulWidget {
  @override
  _WorkoutCreationState createState() => _WorkoutCreationState();
}

class _WorkoutCreationState extends State<WorkoutCreation> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Create Workout", style: TextStyle(fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _nameController,
                    style: TextStyle(color: const Color.fromARGB(255, 14, 13, 13)),
                    decoration: InputDecoration(
                      hintText: 'Workout name',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(179, 19, 19, 19)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 20, 20, 20)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 20, 19, 19)),
                      ),
                    ),
                  ),
                  SizedBox(height: 50), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '4 Exercises',
                        style: TextStyle(color: const Color.fromARGB(255, 15, 14, 14), fontSize: 18),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Color(0xFF39FF14)),
                        iconSize: 48,
                        onPressed: () {
                          // Logic to add exercise
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: ElevatedButton(
              onPressed: () {
                // Button action here
              },
              child: Text(
                'Create',
                style: TextStyle(color: const Color.fromARGB(255, 6, 6, 6), fontSize: 20),
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
    );
  }
}
