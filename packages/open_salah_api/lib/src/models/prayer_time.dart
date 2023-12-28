import 'package:json_annotation/json_annotation.dart';

part 'prayer_time.g.dart';
//Test

@JsonSerializable()
class PrayerTime {
  final String Fajr;
  final String Sunrise;
  final String Dhuhr;
  final String Asr;
  final String Sunset;
  final String Maghrib;
  final String Isha;
  final String Imsak;
  final String Midnight;

  factory PrayerTime.fromJson(Map<String, dynamic> json) =>
      _$PrayerTimeFromJson(json);
  PrayerTime(
      {required this.Fajr,
      required this.Sunrise,
      required this.Dhuhr,
      required this.Asr,
      required this.Sunset,
      required this.Maghrib,
      required this.Isha,
      required this.Imsak,
      required this.Midnight});
}
