import 'package:open_salah_api/open_salah_api.dart';
import 'package:open_salah_api/src/models/readable_date.dart';

class Salah {
  final PrayerTime timings;
  final GregorianDate gregorian;
  final HijriDate hijri;
  final Meta meta;
  final ReadableDate readableDate;


  Salah({
    required this.readableDate,
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
      readableDate: ReadableDate.fromJson(json['date']),

    );
  }

  @override
  String toString() {
    return 'Location:{'
        // 'id:${location.id}'
        // '\name:${location.name}'
        // '\nlatitude:${location.latitude}'
        // '\nlongitude:${location.longitude}'
        'Timings: {'
        '\nfajr:${timings.fajr},'
        '\ndhuhr:${timings.dhuhr},'
        '\nasr:${timings.asr},'
        '\nmaghrib:${timings.maghrib},'
        '\nisha:${timings.isha}}'
        '\nGregorian Date:{\nday:${gregorian.day}'
        '\nmonth:${gregorian.monthEnglish}'
        '\nweekday:${gregorian.weekday}'
        '\nyear:${gregorian.year}'
        '\nnumericalMonth:${gregorian.monthNumerical}'
        '\nEnglishMonth:${gregorian.monthEnglish} }';
  }
}
