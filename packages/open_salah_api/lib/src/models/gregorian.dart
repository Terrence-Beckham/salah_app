import 'package:json_annotation/json_annotation.dart';
part 'gregorian.g.dart';

@JsonSerializable()
class Gregorian {
  final String date;
  final String format;
  final int day;
  final String weekday;
  final int month;
  final String enMonth;
  final int year;
  final String designation;

  factory Gregorian.fromJson(Map<String, dynamic> json) =>
      _$GregorianFromJson(json);
  Gregorian(
      {required this.date,
      required this.format,
      required this.day,
      required this.weekday,
      required this.month,
      required this.enMonth,
      required this.year,
      required this.designation});
}
