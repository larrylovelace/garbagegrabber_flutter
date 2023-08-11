class DateConverter {
  String getMonthFromDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return _getMonthAbbreviation(date.month);
  }

  int getDayFromDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return date.day;
  }

  String _getMonthAbbreviation(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  int remainingdays(String pickupDate) {
    DateTime today = DateTime.now();
    DateTime upcomingPickup = DateTime.parse(pickupDate);

    DateTime todayDate = DateTime(today.year, today.month, today.day);
    DateTime upcomingPickupDate = DateTime(
      upcomingPickup.year,
      upcomingPickup.month,
      upcomingPickup.day,
    );

    Duration difference = upcomingPickupDate.difference(todayDate);
    int remainingDays = difference.inDays;

    return remainingDays;
  }

  int differencepickupdays(String startDateString, String endDateString) {
    DateTime startDate = DateTime.parse(startDateString);
    DateTime endDate = DateTime.parse(endDateString);

    int differenceInDays = endDate.difference(startDate).inDays;
    return differenceInDays;
  }
}
