import 'package:intl/intl.dart';

class CustomDateUtils {
  static String dateToString(DateTime? date) =>
      date != null ? DateFormat('dd.MM.yyyy').format(date) : '';
}
