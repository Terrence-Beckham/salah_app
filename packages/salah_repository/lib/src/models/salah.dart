// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'salah.g.dart';

@Collection(inheritance: false)
class SalahRepo extends Equatable {
  SalahRepo(
      {required this.readableDate,
      required this.fajr,
      required this.sharooq,
      required this.dhuhr,
      required this.asr,
      required this.maghrib,
      required this.isha,
      required this.gregorianDate,
      required this.gregorianDay,
      required this.gregorianMonth,
      required this.gregorianMonthNumeral,
      required this.gregorianYear,
      required this.gregorianWeekdayEnglish,
      required this.hijriDate,
      required this.hijriDay,
      required this.hijriWeekdayEnglish,
      required this.hijriWeekdayArabic,
      required this.hijriMonthEnglish,
      required this.hijriMonthArabic,
      required this.hijriYear,
      required this.city,
      required this.latitude,
      required this.longitude});

  final Id id = Isar.autoIncrement;
  final String fajr;
  final String sharooq;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String gregorianDate;
  final String gregorianDay;
  final String gregorianMonth;
  final int gregorianMonthNumeral;
  final String gregorianYear;
  final String hijriDate;
  final String hijriDay;
  final String hijriWeekdayEnglish;
  final String hijriWeekdayArabic;
  final String hijriMonthEnglish;
  final String hijriMonthArabic;
  final String hijriYear;
  final String readableDate;
  final String gregorianWeekdayEnglish;
  final String city;
  final double latitude;
  final double longitude;

  @override
  String toString() {
    return 'fajr: $fajr,/n dhuhr: $dhuhr,/n asr: $asr,/n maghrib: $maghrib,/n isha: $isha,/n '
        'readableDate: $readableDate,/n gregorianWeekdayEnglish: $gregorianWeekdayEnglish,/n '
        'city: $city,/n gregorianDay: $gregorianDay,/n'
        ' gregorianMonth: $gregorianMonth,/n '
        'gregorianYear: $gregorianYear,/n '
        'gregorianMonthNumeral: $gregorianMonthNumeral';
  }

  @ignore
  @override
  // TODO: implement props
  List<Object?> get props => [
        fajr,
        dhuhr,
        asr,
        maghrib,
        isha,
        gregorianDate,
        gregorianMonth,
        gregorianMonthNumeral,
        gregorianDay,
        gregorianYear,
        hijriDate,
        hijriDay,
        readableDate,
        hijriWeekdayEnglish,
        gregorianWeekdayEnglish,
        hijriWeekdayArabic,
        city,
        hijriYear,
        longitude,
        latitude,
      ];
}
