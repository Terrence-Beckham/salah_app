import 'package:isar/isar.dart';

class HijriDate {
  HijriDate(
    date,
    format,
    day,
    weekday,
    weekdayArabic,
    monthNumerical,
    year,
    monthEnglish,
    monthArabic,
  );

  String? date;
  String? format;
  String? day;
  String? weekday;
  String? weekdayArabic;
  int? monthNumerical;
  String? year;
  String? monthEnglish;
  String? monthArabic;

  factory HijriDate.fromJson(Map<String, dynamic> json) {
    final String date = json['date'] as String;
    final String format = json['format'] as String;
    final String day = json['day'] as String;
    final String weekdayEnglish = json['weekday']['en'] as String;
    final String weekdayArabic = json['weekday']['ar'] as String;
    final int monthNumerical = json['month']['number'] as int;
    final String monthArabic = json['month']['ar'] as String;
    final String monthEnglish = json['month']['en'] as String;
    final String year = json['year'] as String;

    return HijriDate(
       date,
       format,
       day,
       weekdayEnglish,
       weekdayArabic,
       monthNumerical,
      monthArabic,
      monthEnglish,
      year,
    );
  }
}
