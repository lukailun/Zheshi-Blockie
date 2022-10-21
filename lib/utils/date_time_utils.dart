import 'package:intl/intl.dart';

class DateTimeUtils {
  static String dateTimeStringFromTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }
}
