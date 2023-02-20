import 'package:intl/intl.dart';

class CustomDateUtils {
  static String dateToString(DateTime? date) =>
      date != null ? DateFormat('dd.MM.yyyy').format(date) : '';

  static String prepareDateForBackend(DateTime date) =>
      DateFormat('y-MM-dd').format(date);
}
