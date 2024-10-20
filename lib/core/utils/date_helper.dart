import 'package:intl/intl.dart';

/// A helper class for date formatting.
class DateHelper {
  /// Returns a formatted date string for the given [DateTime].
  ///
  /// The date is formatted as 'dd.MM.yy'.
  ///
  /// Example:
  /// ```dart
  /// String formattedDate = DateHelper.getDateFormat(DateTime.now());
  /// ```
  static String getDateFormat(DateTime date) {
    return DateFormat('dd.MM.yy').format(date);
  }
}
