import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:fit_rep/providers/settings_manager.dart';

class CalendarModal extends StatefulWidget {
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
    final settingsProvider = Provider.of<SettingsManager>(context);

    return Dialog(
      backgroundColor: settingsProvider.isDarkMode
          ? Theme.of(context).primaryColorDark
          : Theme.of(context).primaryColorLight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              if (selectedDay.isBefore(DateTime.now())) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: settingsProvider.isDarkMode
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).primaryColorLight,
                      title: Text('Invalid Date',
                          style: TextStyle(fontFamily: 'Kanit')),
                      content: Text('You cannot add a workout on a past date.',
                          style: TextStyle(fontFamily: 'Kanit')),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK',
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  color: Theme.of(context).primaryColor)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
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
                fontWeight: FontWeight.bold,
              ),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              textStyle: TextStyle(fontFamily: 'Kanit'),
            ),
            onPressed: () {
              widget.onSelectedDate(_selectedDay);
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text('Select Date',
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                    color: Theme.of(context).primaryColorDark)),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
