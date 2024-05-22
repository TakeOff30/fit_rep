//lista di workout salvati in una data giornata
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarModal extends StatefulWidget {
  // Add a property to store the initial date
  final Function(DateTime) onSelectedDate;

  CalendarModal({super.key, required this.onSelectedDate});

  @override
  _CalendarModalState createState() => _CalendarModalState();
}

class _CalendarModalState extends State<CalendarModal> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
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
              defaultTextStyle: TextStyle(fontFamily: 'Kanit'),
              todayTextStyle: TextStyle(
                fontFamily: 'Kanit',
                color: Color(0xFF1E1E1E),
                fontWeight: FontWeight.bold,
              ),
              selectedTextStyle: TextStyle(
                  fontFamily: 'Kanit',
                  color: Color(0xFF1E1E1E),
                  fontWeight: FontWeight.bold),
              weekendTextStyle: TextStyle(fontFamily: 'Kanit'),
              holidayTextStyle: TextStyle(fontFamily: 'Kanit'),
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(fontFamily: 'Kanit', fontSize: 18),
              formatButtonVisible: false,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontFamily: 'Kanit'),
              weekendStyle: TextStyle(fontFamily: 'Kanit'),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              widget.onSelectedDate(_selectedDay);
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Select Date'),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
