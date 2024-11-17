import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String get getStringDate {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get getStringUIDate {
    return DateFormat('d MMM yyyy').format(this);
  }
}
