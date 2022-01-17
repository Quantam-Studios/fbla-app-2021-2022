// Packages and Dependencies

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
// Custom made dependencies
import 'sharedRefs.dart';

// The planner page code
class PlannerPage extends StatefulWidget {
  PlannerPageContent createState() => PlannerPageContent();
}

int eventCount = 0;

// Keys for mapping events
EventKeys eventKeys = EventKeys();

@override
class PlannerPageContent extends State {
  // Shared Preferences Configuration
  SharedPref sharedPref = SharedPref();

  // Functions for loading event info
  BetaEvent eventSave = BetaEvent();
  BetaEvent eventLoad = BetaEvent();

  // Functions for loading events
  BetaEvents eventsSave = BetaEvents();
  BetaEvents eventsLoad = BetaEvents();

  loadSharedPrefs() async {
    //TODO: make this scalable. (There needs to be a way for an infinite amount of keys.)
    // Runs for the amount events
    for (int i = 0; i < eventCount; i++) {
      try {
        BetaEvent _event =
            BetaEvent.fromJson(await sharedPref.read(eventKeys.keys[i]));
        setState(() {
          eventsLoad.events[i] = _event;
        });
      } catch (exception) {
        print('loadSharedPrefs() Failed');
        print(eventKeys.keys[i].toString());
        print(exception);
      }
    }
  }

  // calendar initialization
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  // add event pop up initialization
  // Title controller
  TextEditingController titleEditController = TextEditingController(text: '');

  // Initial states, and load data required for planner page
  @override
  void initState() {
    eventCount = 0;
    loadSharedPrefs();
    super.initState();
  }

  // clean up closed pop up widget controllers.
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleEditController.dispose();
    //loadSharedPrefs();
    super.dispose();
  }

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
                            // Add event button
                            trailing: ElevatedButton(
                              onPressed: () => {
                                setState(() {
                                  _addEvent();
                                })
                              },
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
                                  for (var i = 0; i < eventCount; i++)
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
                                          // Date subtitle text
                                          subtitle: Text.rich(
                                            TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.event,
                                                    color: Colors.white
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      // Formats the string which was converted from DateTime and looks something like: "2020-04-17 11:59:46.405"
                                                      // to only show this: 2020-04-17
                                                      '${eventsLoad.events[i].date.substring(0, 10)}',
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.7)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Event title text
                                          title: Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${(i + 1).toString()}.  ${eventsLoad.events[i].title}',
                                                ),
                                              ],
                                            ),
                                          ),
                                          trailing:
                                              // The edit class button
                                              IconButton(
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: Colors.white,
                                            ),
                                            onPressed: () => setState(() {
                                              {
                                                _editEvent(context, i);
                                              }
                                            }),
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

  // TODO: prevent updating all event cards for performance
  // TODO: make the save sytem scalable
  // Save events when edited
  _eventEditSave(int index) {
    print('current dateTime: ' + _selectedDay.toString());
    eventsSave.events[index].title = titleEditController.text;
    eventsSave.events[index].date = _focusedDay.toString();
    sharedPref.save(eventKeys.keys[index], eventsSave.events[index]);
    loadSharedPrefs();
  }

// This is the pop up for adding events.
// function called draws a pop up
  _editEvent(context, int index) {
    // Actual pop up object
    Alert(
        style: AlertStyle(
          backgroundColor: Color(0xff3b3b3b),
          titleStyle: TextStyle(color: Colors.white),
        ),
        context: context,
        title: "Edit Event",
        content: Column(
          children: <Widget>[
            // Title input feild
            TextField(
              controller: titleEditController,
              // limit the string size to a maximum of 20
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
              ],
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.event,
                  color: Colors.white,
                ),
                labelText: 'Event',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        // Confirm button
        buttons: [
          DialogButton(
            onPressed: () => {
              // get rid of pop up
              print('closed'),
              Navigator.of(context, rootNavigator: true).pop(),
              // save the data
              _eventEditSave(index),
            },
            child: Text(
              "Confirm",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ]).show();
  }

  // Add Event functionailty
  void _addEvent() {
    // make sure there are no more than 20 events (this is only for the test build for the sake of performance)
    if (eventCount < 5) {
      eventCount += 1;
      print(eventCount.toString());
    } else {
      print('5 events already added (5 is the maximum value of events)');
    }
  }
} //TableEventsExample build(BuildContext context){}

//TODO: EXTREMELY IMPORTANT: this event system has a limit of 5 events, because the key system isnt infinite.
// we need to consider using firebase or some database system for saving all data in order to make the entire app cleaner, faster, and easier to work with when it comes to coding new features.
class BetaEvent {
  String title = '';
  String date = DateTime.now().toString();
  //DateTime datetime = DateTime.now();

  BetaEvent({String title = '', String date = '2022-01-17 11:59:46.405'});

  BetaEvent.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        date = json['date'];
  // datetime = json['dateTime'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'date': date,
        //'dateTime': datetime,
      };
}

class BetaEvents {
  List events = List.filled(5, BetaEvent());
  BetaEvents();

  Map<String, dynamic> toJson() => {
        'events': events,
      };

  BetaEvents.fromJson(Map<String, dynamic> json) : events = json['events'];
}

class EventKeys {
  List keys = ['0', '1', '2', '3', '4'];
  EventKeys();

  Map<String, dynamic> toJson() => {'keys': keys};

  EventKeys.fromJson(Map<String, dynamic> json) : keys = json['keys'];
}
