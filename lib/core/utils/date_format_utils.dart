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

  static String getFormattedDate(DateTime? date) {
    if (date == null) return '';
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day/$month/$year';
  }

  static String getCurrentDateFormatted() {
    DateTime now = DateTime.now();
    String day = now.day.toString().padLeft(2, '0');
    String month = now.month.toString().padLeft(2, '0');
    String year = now.year.toString();

    int hour = now.hour;
    String period = hour >= 12 ? 'pm' : 'am';
    if (hour > 12) hour -= 12;
    if (hour == 0) hour = 12;

    String formattedHour = hour.toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');

    return '$day/$month/$year | $formattedHour:$minute$period';
  }

  static String getFormattedTime(String selectedHour, String selectedMinute) {
    if (selectedHour.isNotEmpty || selectedMinute.isNotEmpty) {
      return '00:00 PM';
    }

    int hourInt = int.parse(selectedHour!);
    String period = 'AM';

    if (hourInt > 12) {
      hourInt -= 12;
      period = 'PM';
    } else if (hourInt == 12) {
      period = 'PM';
    } else if (hourInt == 0) {
      hourInt = 12;
    }

    String formattedHour = hourInt.toString().padLeft(2, '0');

    return '$formattedHour:$selectedMinute $period';
  }
}
