class HijriDate {
  HijriDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.weekdayArabic,
    required this.monthNumerical,
    required this.year,
    required this.monthEnglish,
    required this.monthArabic,
  });

  final String date;
  final String format;
  final String day;
  final String weekday;
  final String weekdayArabic;
  final int monthNumerical;
  final String year;
  final String monthEnglish;
  final String monthArabic;

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
      date: date,
      format: format,
      day: day,
      weekday: weekdayEnglish,
      weekdayArabic: weekdayArabic,
      monthNumerical: monthNumerical,
      monthArabic: monthArabic,
      monthEnglish: monthEnglish,
      year: year,
    );
  }
}
