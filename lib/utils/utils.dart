import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:intl/intl.dart';

import '../models/contests.dart';

class Utils {
  static getTime(int time) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    String d = DateFormat.MMMd().format(date);
    String ti = DateFormat.jm().format(date);
    String string = d + " " + ti;
    return string;
  }

  static String getTimeNow() {
    DateTime date = DateTime.now();
    String d = DateFormat.MMMd().format(date);
    String ti = DateFormat.jm().format(date);
    String string = d + " " + ti;
    return string;
  }

  static isAfterTime(int time) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    DateTime today = DateTime.now();
    return (date.isAfter(today));
  }

  static addToCalendar(Contest res) {
    return Event(
      title: res.name,
      description: res.type.toString(),
      location: 'Event location',
      startDate:
          DateTime.fromMillisecondsSinceEpoch(res.startTimeSeconds * 1000),
      endDate: DateTime.fromMillisecondsSinceEpoch(
          res.startTimeSeconds * 1000 + res.durationSeconds * 1000),
    );
  }
}
