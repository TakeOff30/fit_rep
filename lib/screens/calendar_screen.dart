import 'package:fit_rep/components/workout_card.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fit_rep/screens/workout_creation.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  List<Workout> _selectedDayWorkouts = [];

  @override
  Widget build(BuildContext context) {
    var workoutsManager = Provider.of<WorkoutsManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Workouts Log',
          style: TextStyle(
              fontFamily: 'Roboto', fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _selectedDayWorkouts =
                    workoutsManager.getWorkoutsByDay(selectedDay);
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0xFF39FF14),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Color(0xFF39FF14).withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(fontFamily: 'Roboto'),
              todayTextStyle: TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xFF1E1E1E),
                fontWeight: FontWeight.bold,
              ),
              selectedTextStyle: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF1E1E1E),
                  fontWeight: FontWeight.bold),
              weekendTextStyle: TextStyle(fontFamily: 'Roboto'),
              holidayTextStyle: TextStyle(fontFamily: 'Roboto'),
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(fontFamily: 'Roboto', fontSize: 18),
              formatButtonVisible: false,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontFamily: 'Roboto'),
              weekendStyle: TextStyle(fontFamily: 'Roboto'),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: _selectedDayWorkouts
                  .map((workout) => WorkoutCard(workout: workout))
                  .toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WorkoutCreation()),
          );
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
