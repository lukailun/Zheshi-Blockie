// Package imports:
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

enum DateFormatType {
  YYYY_MM_DD_HH_MM('yyyy-MM-dd HH:mm'),
  YYYY_MM_DD_HH_MM_SS('yyyy-MM-dd HH:mm:ss'),
  MM_DD_EEE_HH_MM('MM月dd日 EEE HH:mm');

  const DateFormatType(this.value);

  final String value;
}

class DateTimeUtils {
  static String dateTimeStringFromTimestamp({
    required int timestamp,
    required DateFormatType dateFormatType,
  }) {
    initializeDateFormatting();
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat(dateFormatType.value, 'zh_CN').format(date);
  }
}
