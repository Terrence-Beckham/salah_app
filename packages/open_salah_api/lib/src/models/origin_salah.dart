import 'package:open_salah_api/open_salah_api.dart';

class OriginSalah {
  final PrayerTime timings;
  final GregorianDate gregorian;
  final HijriDate hijri;
  final Meta meta;

  OriginSalah({
    required this.timings,
    required this.gregorian,
    required this.hijri,
    required this.meta,
  });

  factory OriginSalah.fromJson(Map<String, dynamic> json) {
    return OriginSalah(
      timings: PrayerTime.fromJson(json['timings']),
      gregorian: GregorianDate.fromJson(json['date']['gregorian']),
      hijri: HijriDate.fromJson(json['date']['hijri']),
      meta: Meta.fromJson(json['meta']),
    );
  }

  @override
  String toString() {
    return 'Timings: {\nfajr:${timings.fajr},\ndhuhr:${timings.dhuhr},\nasr:${timings.asr},\n'
        'maghrib:${timings.maghrib},\nisha:${timings.isha}\n}';
  }
}
