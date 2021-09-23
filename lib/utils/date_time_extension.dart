import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatTimeString() {
    if (this != null) return DateFormat('HH:mm').format(this);
    return '';
  }

  String formatMonthYearString() {
    if (this != null) return DateFormat('MM/yyyy').format(this);
    return '';
  }

  String formatDateTimeString() {
    if (this != null) return DateFormat('dd/MM/yyyy HH:mm').format(this);
    return '';
  }

  String formatTimeDateString() {
    if (this != null) return DateFormat('HH:mm dd/MM/yyyy').format(this);
    return '';
  }

  String formatDayString() {
    if (this != null) return DateFormat('dd').format(this);
    return '';
  }

  String formatMonthString() {
    if (this != null) return DateFormat('MMM').format(this);
    return '';
  }

  String formatDateDefault() {
    // ignore: unnecessary_null_comparison
    if (this != null) return DateFormat('dd/MM/yyyy').format(this);
    return '';
  }

  String formatDayOfBirthday() {
    if (this != null) return DateFormat('MMM dd, yyyy').format(this);
    return '';
  }

  String formatDayMonth() {
    if (this != null) return DateFormat('dd/MM').format(this);
    return '';
  }

  String formatMonth() {
    if (this != null) return DateFormat('M').format(this);
    return '';
  }

  String formatMonthYear() {
    if (this != null) return DateFormat('M/yy').format(this);
    return '';
  }

  String formatMonthYearFull() {
    if (this != null) return DateFormat('M/yyyy').format(this);
    return '';
  }

  String formatSingleDay() {
    if (this != null) return DateFormat('d').format(this);
    return '';
  }

  String formatSingleDayMonth() {
    if (this != null) return DateFormat('d/M').format(this);
    return '';
  }

  int? toIntDate() {
    if (this != null) return (this.millisecondsSinceEpoch / 1000).round();
    return null;
  }

  DateTime getStartOfDate() {
    return DateTime(this.year, this.month, this.day);
  }

  DateTime getEndOfDate() {
    return DateTime(this.year, this.month, this.day, 23, 59, 59);
  }

  int get weekOfYear {
    // Add 3 to always compare with January 4th, which is always in week 1
    // Add 7 to index weeks starting with 1 instead of 0
    final woy = ((ordinalDate - weekday + 10) ~/ 7);

    // If the week number equals zero, it means that the given date belongs to the preceding (week-based) year.
    if (woy == 0) {
      // The 28th of December is always in the last week of the year
      return DateTime(year - 1, 12, 28).weekOfYear;
    }

    // If the week number equals 53, one must check that the date is not actually in week 1 of the following year
    if (woy == 53 &&
        DateTime(year, 1, 1).weekday != DateTime.thursday &&
        DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return 1;
    }

    return woy;
  }

  /// The ordinal date, the number of days since December 31st the previous year.
  ///
  /// January 1st has the ordinal date 1
  ///
  /// December 31st has the ordinal date 365, or 366 in leap years
  int get ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
  }

  /// True if this date is on a leap year.
  bool get isLeapYear {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }
}
