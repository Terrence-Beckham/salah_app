import 'package:isar/isar.dart';

class Salah {
  Id id = Isar.autoIncrement;
  final double latitude;
  final double longitude;
  final String fajr;
  final String sharooq;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  ///Dates Gregorian
  final String gregorianDate;
  final String gregorianDay;
  final String gregorianWeekday;
  final String gregorianMonth;
  final String gregorianYear;

  ///Dates Hijiri
  final String hijriDate;
  final String hijriWeekdayEnglish;
  final String hijriWeekdayArabic;
  final String hijriMonthEnglish;
  final String hijriMonthArabic;
  final String hijriYear;
  final int method;
  final String methodName;
  final String readableDate;
  final String city;

  //
  // final PrayerTime timings;
  //
  // final GregorianDate gregorian;
  // final HijriDate hijri;
  // final Meta meta;
  // final ReadableDate readableDate;
  // final String city;

  // final ReverseGeolocation reverseGeolocation;

  Salah(
      {required this.latitude,
      required this.longitude,
      required this.fajr,
      required this.sharooq,
      required this.dhuhr,
      required this.asr,
      required this.maghrib,
      required this.isha,
      required this.gregorianDate,
      required this.gregorianDay,
      required this.gregorianWeekday,
      required this.gregorianMonth,
      required this.gregorianYear,
      required this.hijriDate,
      required this.hijriWeekdayEnglish,
      required this.hijriWeekdayArabic,
      required this.hijriMonthEnglish,
      required this.hijriMonthArabic,
      required this.hijriYear,
      required this.method,
      required this.methodName,
      required this.readableDate,
      required this.city});

  factory Salah.fromJson(Map<String, dynamic> json, String localCity) {
    final String city = localCity;
    final double latitude = json['meta']['latitude'] as double;
    final double longitude = json['meta']['longitude'] as double;
    final String fajr = json['timings']['Fajr'] as String;
    final String sharooq = json['timings']['Sunrise'] as String;
    final String dhuhr = json['timings']['Dhuhr'] as String;
    final String asr = json['timings']['Asr'] as String;
    final String maghrib = json['timings']['Maghrib'] as String;
    final String isha = json['timings']['Isha'] as String;

    final String readableDate = json['date']['readable'] as String;

    ///Dates Gregoria as Stringn
    final String gregorianDate = json['date']['gregorian']['date'] as String;
    final String gregorianDay = json['date']['gregorian']['day'] as String;
    final String gregorianWeekday =
        json['date']['gregorian']['weekday']['en'] as String;
    final String gregorianMonth =
        json['date']['gregorian']['month']['en'] as String;
    final String gregorianYear = json['date']['gregorian']['year'] as String;

    ///Dates Hijir as Stringi
    final String hijriDate = json['date']['hijri']['date'] as String;
    final String hijriWeekdayEnglish =
        json['date']['hijri']['weekday']['en'] as String;
    final String hijriWeekdayArabic =
        json['date']['hijri']['weekday']['ar'] as String;
    final String hijriMonthEnglish =
        json['date']['hijri']['month']['en'] as String;
    final String hijriMonthArabic =
        json['date']['hijri']['weekday']['ar'] as String;
    final String hijriYear = json['date']['hijri']['year'] as String;
    final int method = json['meta']['method']['id'] as int;
    final String methodName = json['meta']['method']['name'] as String;

    return Salah(
      fajr: fajr,
      sharooq: sharooq,
      dhuhr: dhuhr,
      asr: asr,
      maghrib: maghrib,
      isha: isha,
      gregorianDate: gregorianDate,
      gregorianDay: gregorianDay,
      gregorianWeekday: gregorianWeekday,
      gregorianMonth: gregorianMonth,
      gregorianYear: gregorianYear,
      hijriDate: hijriDate,
      hijriWeekdayEnglish: hijriWeekdayEnglish,
      hijriWeekdayArabic: hijriWeekdayArabic,
      hijriMonthEnglish: hijriMonthEnglish,
      hijriMonthArabic: hijriMonthArabic,
      hijriYear: hijriYear,
      method: method,
      methodName: methodName,
      readableDate: readableDate,
      city: city,
      latitude: latitude,
      longitude: longitude,
      // timings: PrayerTime.fromJson(json['timings']),
      // gregorian: GregorianDate.fromJson(json['date']['gregorian']),
      // hijri: HijriDate.fromJson(json['date']['hijri']),
      // meta: Meta.fromJson(json['meta']),
      // readableDate: ReadableDate.fromJson(json['date']),
      // city: city,
      // reverseGeolocation: ReverseGeolocation.fromJson(json),
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
        '\nfajr:$fajr,'
        '\ndhuhr:$dhuhr,'
        '\nasr:$asr,'
        '\nmaghrib:$maghrib,'
        '\nisha:$isha'
        '\nGregorian Date:{\nday:$gregorianDay'
        '\nmonth:$gregorianMonth'
        '\nweekday:$gregorianWeekday'
        '\nyear:$gregorianYear';
  }
}
