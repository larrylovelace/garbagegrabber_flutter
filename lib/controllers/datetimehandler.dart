import 'package:intl/intl.dart';

class DateGenerator {
  static List<Map<String, dynamic>> getDates(String startDate, String endDate) {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);

    List<Map<String, dynamic>> dateList = [];

    dateList.add({
      'month': DateFormat.MMM().format(start),
      'day': start.day,
    });

    while (start.isBefore(end)) {
      start = start.add(const Duration(days: 1));
      if (start.weekday == DateTime.monday ||
          start.weekday == DateTime.wednesday ||
          start.weekday == DateTime.friday) {
        dateList.add({
          'month': DateFormat.MMM().format(start),
          'day': start.day,
        });
      }
    }

    return dateList;
  }
}
