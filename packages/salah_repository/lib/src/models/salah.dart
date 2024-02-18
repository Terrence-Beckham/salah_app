// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

class SalahRepo extends Equatable {
  SalahRepo({
    required this.readableDate,
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.gregorianDate,
    required this.gregorianWeekdayEnglish,
  });

  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String gregorianDate;
  final String readableDate;
  final String gregorianWeekdayEnglish;

  @override
  String toString() {
    return 'fajr: $fajr, dhuhr: $dhuhr, asr: $asr, maghrib: $maghrib, isha: $isha, '
        'readableDate: $readableDate  ,gregorianWeekdayEnglish: $gregorianWeekdayEnglish ';
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [fajr, dhuhr, asr, maghrib, isha, gregorianDate, readableDate,gregorianWeekdayEnglish];
}
