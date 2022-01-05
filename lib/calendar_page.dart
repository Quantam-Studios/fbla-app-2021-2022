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

@override
class TableEventsExample extends StatelessWidget {
  CalendarFormat format = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: SingleChildScrollView(
        child: Container(
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              side: BorderSide(color: Colors.white, width: 2.0),
            ),
            color: Color(0xff121212),
            margin: const EdgeInsets.all(8.0),
            child: TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime(2021),
              lastDay: DateTime(2023),
              calendarFormat: format,

              // Calendar Header Styling
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
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
              daysOfWeekStyle: const DaysOfWeekStyle(
                // Weekend days color (Sat,Sun)
                weekendStyle: TextStyle(color: Color(0xff82B7FF)),
              ),
              // Calendar Dates styling
              calendarStyle: CalendarStyle(
                // Weekend dates color (Sat & Sun Column)
                weekendTextStyle: TextStyle(color: Color(0xff82B7FF)),
                // highlighted color for today
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                // highlighted color for selected day
                selectedDecoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                withinRangeTextStyle: TextStyle(
                  color: Colors.white,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
                defaultTextStyle: TextStyle(color: Colors.white),
              ),
              onFormatChanged: (CalendarFormat _format) {
                setState() {
                  format = _format;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
} //TableEventsExample build(BuildContext context){}