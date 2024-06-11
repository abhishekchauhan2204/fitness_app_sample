import 'package:fitness_app_sample/Widget%20common/circular%20graph.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Widget common/textstyle.dart';
import '../provider/provider.dart';
import 'scheduleitem.dart';


class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  DateTime SelectedDay = DateTime.now();
  DateTime FocusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    bool isWarmupCompleted = Provider.of<WarmupState>(context).isCompleted;
    bool isHiitCompleted = Provider.of<WarmupStateHiit>(context).isCompleted;

    return Scaffold(
      backgroundColor: Color(0xFF1C1B2E),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today is",
                    style: tb35(rang: Colors.white70),
                  ),
                  Text(DateFormat('dd, MMMM yyyy').format(DateTime.now()),
                      style: tb30(rang: Colors.white70)),
                ],
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: FocusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(SelectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  SelectedDay = selectedDay;
                  FocusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: true,
                defaultTextStyle: TextStyle(color: Colors.white),
                weekendTextStyle: TextStyle(color: Colors.white),
                todayTextStyle: TextStyle(color: Colors.white),
                selectedTextStyle: TextStyle(color: Colors.white),
                disabledTextStyle: TextStyle(color: Colors.grey),
                outsideTextStyle: TextStyle(color: Colors.grey),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.white),
                weekendStyle: TextStyle(color: Colors.white),
              ),
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(color: Colors.white),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                ),
                rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ScheduleItem(voidcall: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CircularGraphScreen(),));
                  },
                    time: '8am',
                    title: 'WarmUp',
                    description: 'Run 02 km',
                    backgroundColor: Colors.blue.shade200,
                    isCompleted: isWarmupCompleted,
                  ),
                  ScheduleItem(voidcall: () {

                  },
                    time: '4pm',
                    title: 'Pushups session',
                    description: '25 rep, 3 sets with 20 sec rest',
                    backgroundColor: Colors.yellow.shade200,
                    isCompleted: isHiitCompleted,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
