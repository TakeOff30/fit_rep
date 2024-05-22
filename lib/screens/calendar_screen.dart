import 'package:fit_rep/components/generics/workout_card.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/providers/workouts_manager.dart';
import 'package:fit_rep/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fit_rep/screens/workout_creation_screen.dart';
import 'package:fit_rep/providers/settings_manager.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 23, 59, 59);
  List<Workout> _selectedDayWorkouts = [];

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsManager>(context);

    return Consumer<WorkoutsManager>(
        builder: (context, workoutsManager, child) {
      _selectedDayWorkouts = workoutsManager.getWorkoutsByDay(_selectedDay);
      List<String> workoutDates = workoutsManager.getWorkoutDates();
      print(workoutDates);

      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Workouts Log',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24,
                fontWeight: FontWeight.bold),
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
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
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
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (workoutDates.contains(formatDate(date))) {
                    return Positioned(
                      bottom: 1,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 80, 200, 120),
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                },
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
        floatingActionButton: (_selectedDay.isBefore(DateTime.now()))
            ? null
            : FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            WorkoutCreationScreen(date: _selectedDay)),
                  );
                },
                child: Icon(
                  Icons.add,
                  color: Color(0xFF1E1E1E),
                ),
                shape: CircleBorder(),
                backgroundColor: Theme.of(context).primaryColor,
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
