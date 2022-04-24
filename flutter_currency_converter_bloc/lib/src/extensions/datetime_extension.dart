import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String prettyDate(String format) => DateFormat(format).format(this);
}
