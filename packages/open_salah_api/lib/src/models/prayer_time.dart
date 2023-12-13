import 'package:json_annotation/json_annotation.dart';

part 'prayer_time.g.dart';

@JsonSerializable()
class PrayerTime {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;

  factory PrayerTime.fromJson(Map<String, dynamic> json) =>
      _$PrayerTimeFromJson(json);
  PrayerTime(
      {required this.fajr,
      required this.sunrise,
      required this.dhuhr,
      required this.asr,
      required this.sunset,
      required this.maghrib,
      required this.isha,
      required this.imsak,
      required this.midnight});
}
