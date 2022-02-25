extension TimeLeft on DateTime {
  String getGaweanTimeLeft(int millisecondEndDate) {

    DateTime other = DateTime.fromMillisecondsSinceEpoch(millisecondEndDate);

    int days = other.difference(this).inDays;
    int hours = other.difference(this).inHours;
    int minutes = other.difference(this).inMinutes;
    String timeLeftText = "-";

    if (millisecondEndDate > 0){
      if (days > 1){
        timeLeftText = "Sisa $days Hari";
      } else if (hours > 1) {
        timeLeftText = "Sisa $hours Jam";
      } else if (minutes > 1) {
        timeLeftText = "Sisa $minutes Menit";
      } else if (minutes == 0){
        timeLeftText = "Timeout";
      } else {
        timeLeftText = "-";
      }
    }
    return timeLeftText;
  }
}