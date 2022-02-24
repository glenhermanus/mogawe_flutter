extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }

  bool isTomorrowDate(DateTime other) {
    return year == other.year && month == other.month
        && (day + 1) == other.day;
  }
}