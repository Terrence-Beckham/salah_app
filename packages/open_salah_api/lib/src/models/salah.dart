import 'package:json_annotation/json_annotation.dart';
import 'package:open_salah_api/src/open_salah_api.dart';

class Salah {
  final PrayerTime timings;
  final GregorianDate gregorian;
  final HijriDate hijri;
  final Meta meta;

  Salah({
    required this.timings,
    required this.gregorian,
    required this.hijri,
    required this.meta,
  });

  factory Salah.fromJson(Map<String, dynamic> json) {
    return Salah(
      timings: PrayerTime.fromJson(json['timings']),
      gregorian: GregorianDate.fromJson(json['date']['gregorian']),
      hijri: HijriDate.fromJson(json['date']['hijri']),
      meta: Meta.fromJson(json['meta']),
    );
  }
}
