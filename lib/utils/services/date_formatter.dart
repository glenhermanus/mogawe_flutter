import 'package:intl/intl.dart';

class DateFormatter {
  String formatDateTime(DateTime datetime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(datetime);
    return formatted;
  }

  String formatDateMMMddyyyy(DateTime datetime) {
    final DateFormat formatter = DateFormat('MMM dd, yyyy');
    final String formatted = formatter.format(datetime);
    return formatted;
  }
}
