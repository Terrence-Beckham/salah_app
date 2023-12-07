import 'package:json_annotation/json_annotation.dart';
part 'hijiri.g.dart';

@JsonSerializable()
class HijriDate {
  final String date;
  final String format;
  final int day;
  final String weekday;
  final int month;
  final String enMonth;
  final int year;
  final String designation;
  final List<String> holidays;
  factory HijriDate.fromJson(Map<String, dynamic> json) =>
      _$HijriDateFromJson(json);
  HijriDate(
      {required this.date,
      required this.format,
      required this.day,
      required this.weekday,
      required this.month,
      required this.enMonth,
      required this.year,
      required this.designation,
      required this.holidays});
}
