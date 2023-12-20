import 'package:json_annotation/json_annotation.dart';

part 'gregorian_date.g.dart';

@JsonSerializable()
class GregorianDate {
  final String date;
  final String format;
  final int day;
  final String weekday;
  final int month;
  final String english;
  final int year;
  final String designation;
  factory GregorianDate.fromJson(Map<String, dynamic> json) =>
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
