import 'package:freezed_annotation/freezed_annotation.dart';

part 'gregorian_date.freezed.dart';
part 'gregorian_date.g.dart';

@freezed
class GregorianDate {
  final String date;
  final String format;
  final String day;
  final String weekday;
  final String month;
  final String english;
  final String year;
  final String designation;

  factory GregorianDate.fromJson(Map<String, Object?> json) =>
      _$GregorianDateFromJson(json);

  GregorianDate(
      {required this.date,
      required this.format,
      required this.day,
      required this.weekday,
      required this.month,
      required this.english,
      required this.year,
      required this.designation});
}
