import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String get getStringDate {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}
