import 'package:json_annotation/json_annotation.dart';

part 'hijiri.g.dart';

@JsonSerializable()
class HijriDate {
  HijriDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.shr,
    required this.year,
    required this.designation,
  });
  final String date;
  final String format;
  final int day;
  final String weekday;
  final int month;
  final String shr;
  final int year;
  final String designation;

  factory HijriDate.fromJson(Map<String, dynamic> json) =>
      _$HijriDateFromJson(json);
}
