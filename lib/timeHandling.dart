import 'package:flutter/material.dart';

class CheckTimes {
  List<TimeOfDay> checkTimes = [
    // Early Bird
    TimeOfDay(hour: 7, minute: 30),
    // 1st Period
    TimeOfDay(hour: 8, minute: 30),
    // 2nd Period
    TimeOfDay(hour: 9, minute: 30),
    // 3rd Period
    TimeOfDay(hour: 10, minute: 30),
    // 4th Period
    TimeOfDay(hour: 12, minute: 5),
    // 5th Period
    TimeOfDay(hour: 13, minute: 5),
    // 6th Period
    TimeOfDay(hour: 14, minute: 5),
  ];
  CheckTimes();

  Map<String, dynamic> toJson() => {
        'checkTimes': checkTimes,
      };

  CheckTimes.fromJson(Map<String, dynamic> json)
      : checkTimes = json['checkTimes'];
}

// Gets the current time from the device formmated like 00:00 hh/mm
getCurrentTime() {
  TimeOfDay dateTime = TimeOfDay.now();
  print(dateTime.hour.toString() + dateTime.minute.toString());
  return dateTime.toString();
}

// Compare extension DO NOT CALL THIS INSTEAD CALL checkIfUpdateNeeded()
extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;
    return 0;
  }
}

// The method for comparing times in TimeOfDay formats returns an int
// 0 = no difference, -1 = less, 1 = greater
checkIfUpdateNeeded(TimeOfDay other) {
  return TimeOfDay.now().compareTo(other);
}
