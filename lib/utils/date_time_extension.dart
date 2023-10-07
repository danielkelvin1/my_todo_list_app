import 'package:flutter/material.dart';

extension ConvertStringToDate on String {
  DateTime convertToDate() {
    var listYear = split('-');
    var year = int.parse(listYear[0]);
    var month = int.parse(listYear[1]);
    var day = int.parse(listYear[2]);
    return DateTime(year, month, day);
  }

  TimeOfDay convertToTimeOfDay() {
    var listTime = split(':');
    var hour = int.parse(listTime[0]);
    var minute = int.parse(listTime[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
