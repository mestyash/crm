import 'package:intl/intl.dart';

class CustomDateUtils {
  static String dateToString(DateTime? date) =>
      date != null ? DateFormat('dd.MM.yyyy').format(date) : '';

  static String prepareDateForBackend(DateTime date) =>
      DateFormat('y-MM-dd').format(date);

  static DateTime firstOrLastDateOfCurrentMonth({bool first = true}) {
    final now = DateTime.now();
    final month = first ? now.month : now.month + 1;
    final day = first ? 1 : 0;
    return DateTime(now.year, month, day);
  }
}
