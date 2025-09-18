import 'package:intl/intl.dart';

class DateFormatUtils {
  static String formatToDisplayDate(String? isoDateString) {
    if (isoDateString == null || isoDateString.isEmpty) {
      return '';
    }

    try {
      DateTime dateTime = DateTime.parse(isoDateString);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return 'N/A';
    }
  }
}
