class GregorianDate {
  final String date;
  final String format;
  final String day;
  final String weekday;
  final String year;
  final int monthNumerical;
  final String monthEnglish;

  // factory GregorianDate.fromJson(Map<String, Object?> json) =>
  //     _$GregorianDateFromJson(json);
  factory GregorianDate.fromJson(Map<String, dynamic> json) {
    final String date = json['date'] as String;

    final String format = json['format'] as String;
    final String day = json['day'] as String;
    final String weekday = json['weekday']['en'] as String;
    final int monthNumerical = json['month']['number'] as int;
    final String monthEnglish = json['month']['en'] as String;
    final String year = json['year'] as String;

    return GregorianDate(
      monthNumerical: monthNumerical,
      monthEnglish: monthEnglish,
      date: date,
      format: format,
      day: day,
      weekday: weekday,
      year: year,
    );
  }

  GregorianDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.year,
    required this.monthNumerical,
    required this.monthEnglish,
  });
}
