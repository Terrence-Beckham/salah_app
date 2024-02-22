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
      required this.gregorianWeekdayEnglish,
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
  final String readableDate;
  final String gregorianWeekdayEnglish;
  final String city;
  final double latitude;
  final double longitude;

  @override
  String toString() {
    return 'fajr: $fajr, dhuhr: $dhuhr, asr: $asr, maghrib: $maghrib, isha: $isha, '
        'readableDate: $readableDate  ,gregorianWeekdayEnglish: $gregorianWeekdayEnglish, city: $city ';
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
        readableDate,
        gregorianWeekdayEnglish,
        city,
        longitude,
        latitude,
      ];
}
