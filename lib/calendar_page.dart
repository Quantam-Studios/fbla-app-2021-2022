// import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/main.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:table_calendar/table_calendar.dart';
// import "calendar_read.dart";
// import 'dart:collection';

// class Event {
//   final String title;

//   const Event(this.title);

//   @override
//   String toString() => title;
// }

// int getHashCode(DateTime key) {
//   return key.day * 1000000 + key.month * 10000 + key.year;
// }

// Map<DateTime, List<Event>> kEventSource = readCalendar();

// class TableEventsExample extends StatefulWidget {
//   @override
//   _TableEventsExampleState createState() => _TableEventsExampleState();
// }

// class _TableEventsExampleState extends State<TableEventsExample> {
//   final kEvents = LinkedHashMap<DateTime, List<Event>>(
//     equals: isSameDay,
//     hashCode: getHashCode,
//   )..addAll(kEventSource);

//   late final ValueNotifier<List<Event>> _selectedEvents;
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
//       .toggledOff; // Can be toggled on/off by longpressing a date
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   DateTime? _rangeStart;
//   DateTime? _rangeEnd;
//   @override
//   void initState() {
//     super.initState();

//     _selectedDay = _focusedDay;
//     _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
//   }

//   @override
//   void dispose() {
//     _selectedEvents.dispose();
//     super.dispose();
//   }

//   List<Event> _getEventsForDay(DateTime day) {
//     // Implementation example
//     return kEvents[day] ?? [];
//   }

//   // List<Event> _getEventsForRange(DateTime start, DateTime end) {
//   // Implementation example
//   // final days = daysInRange(start, end);

//   // return [
//   //   for (final d in days) ..._getEventsForDay(d),
//   // ];
//   //}

//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     if (!isSameDay(_selectedDay, selectedDay)) {
//       setState(() {
//         _selectedDay = selectedDay;
//         _focusedDay = focusedDay;
//         _rangeStart = null; // Important to clean those
//         _rangeEnd = null;
//         _rangeSelectionMode = RangeSelectionMode.toggledOff;
//       });

//       _selectedEvents.value = _getEventsForDay(selectedDay);
//     }
//   }

//   //void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
//   //  setState(() {
//   //   _selectedDay = null;
//   //  _focusedDay = focusedDay;
//   //   _rangeStart = start;
//   //    _rangeEnd = end;
//   //    _rangeSelectionMode = RangeSelectionMode.toggledOn;
//   // });

//   // `start` or `end` could be null
// //    if (start != null && end != null) {
//   //    _selectedEvents.value = _getEventsForRange(start, end);
//   //  } else if (start != null) {
//   //   _selectedEvents.value = _getEventsForDay(start);
//   //  } else if (end != null) {
//   //   _selectedEvents.value = _getEventsForDay(end);
//   // }
//   // }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           TableCalendar<Event>(
//             firstDay: DateTime.utc(2021, 08, 01),
//             lastDay: DateTime.utc(2022, 06, 30),
//             focusedDay: _focusedDay,
//             selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//             rangeStartDay: _rangeStart,
//             rangeEndDay: _rangeEnd,
//             calendarFormat: _calendarFormat,
//             rangeSelectionMode: _rangeSelectionMode,
//             eventLoader: _getEventsForDay,
//             startingDayOfWeek: StartingDayOfWeek.monday,
//             calendarStyle: CalendarStyle(
//               // Use `CalendarStyle` to customize the UI
//               outsideDaysVisible: false,
//             ),
//             onDaySelected: _onDaySelected,
//             //onRangeSelected: _onRangeSelected,
//             onFormatChanged: (format) {
//               if (_calendarFormat != format) {
//                 setState(() {
//                   _calendarFormat = format;
//                 });
//               }
//             },
//             onPageChanged: (focusedDay) {
//               _focusedDay = focusedDay;
//             },
//           ),
//           const SizedBox(height: 8.0),
//           ValueListenableBuilder<List<Event>>(
//             valueListenable: _selectedEvents,
//             builder: (context, value, _) {
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: value.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 12.0,
//                       vertical: 4.0,
//                     ),
//                     decoration: BoxDecoration(
//                       border: Border.all(),
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: ListTile(
//                       onTap: () => print('${value[index]}'),
//                       title: Text('${value[index]}'),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// Zach Code
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyEvents {
  final String eventTitle;
  final String eventDescp;

  MyEvents({required this.eventTitle, required this.eventDescp});

  @override
  String toString() => eventTitle;
}

// The planner page code

class PlannerPage extends StatefulWidget {
  PlannerPageContent createState() => PlannerPageContent();
}

@override
class PlannerPageContent extends State {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Calendar container
              Container(
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    side: BorderSide(color: Color(0xff3b3b3b), width: 2.0),
                  ),
                  color: Color(0xff121212),
                  margin: const EdgeInsets.all(8.0),
                  // Calendar widget
                  child: TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: DateTime(2021),
                    lastDay: DateTime(2023),
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      // Use `selectedDayPredicate` to determine which day is currently selected.
                      // If this returns true, then `day` will be marked as selected.

                      // Using `isSameDay` is recommended to disregard
                      // the time-part of compared DateTime objects.
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        // Call `setState()` when updating the selected day
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        // Call `setState()` when updating calendar format
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      // No need to call `setState()` here
                      _focusedDay = focusedDay;
                    },

                    // Calendar Header Styling
                    headerStyle: HeaderStyle(
                      titleTextStyle:
                          TextStyle(color: Colors.white, fontSize: 20.0),
                      decoration: BoxDecoration(
                          color: Color(0xff3b3b3b),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      formatButtonTextStyle:
                          TextStyle(color: Colors.white, fontSize: 16.0),
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Colors.blue,
                        size: 28,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Colors.blue,
                        size: 28,
                      ),
                    ),
                    // Calendar Days Styling
                    daysOfWeekStyle: DaysOfWeekStyle(
                      // Weekend days color (Sat,Sun)
                      weekendStyle: TextStyle(color: Color(0xff82B7FF)),
                    ),
                    // Calendar Dates styling
                    calendarStyle: CalendarStyle(
                      // Weekend dates color (Sat & Sun Column)
                      weekendTextStyle: TextStyle(color: Color(0xff82B7FF)),
                      // highlighted color for today
                      // get rid of all decoration for the current day
                      todayDecoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.0),
                      ),
                      // highlighted color for selected day
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      withinRangeTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                      selectedTextStyle: TextStyle(color: Colors.white),
                      defaultTextStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              // Below the calendar
              // View events
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10.0),
                color: Color(0xFF121212),
                height: 600,
                child: Container(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      color: Color(0xFF3b3b3b),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            // Title (top bar of events container)
                            title: Center(
                              child: Row(
                                children: [
                                  Center(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.format_list_bulleted_rounded,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          ' Events.',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () => {},
                              child: Icon(Icons.add, color: Colors.white),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(10),
                                primary: Colors.blue, // <-- Button color
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                children: <Widget>[
                                  for (var i = 0; i < 7; i++)
                                    // Class card
                                    Container(
                                      decoration: new BoxDecoration(
                                        boxShadow: [
                                          new BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                      ),
                                      // content of container
                                      child: Card(
                                        color: Color(0xff5b5b5b),
                                        child: ListTile(
                                          // Room text
                                          subtitle: Text.rich(
                                            TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.meeting_room_outlined,
                                                    color: Colors.white
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' test',
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.7)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Class text
                                          title: Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${i.toString()}. test  ',
                                                ),
                                              ],
                                            ),
                                          ),
                                          trailing: Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.access_time,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' test',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} //TableEventsExample build(BuildContext context){}

// newEvent() function creates a new event on the calendar
// Called when the add event button is pressed
void newEvent(DateTime _selectedDate) {
  print('$_selectedDate');
}
