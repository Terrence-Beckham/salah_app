// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

class SalahRepo extends Equatable {
  SalahRepo(
      {required this.fajr,
      required this.dhuhr,
      required this.asr,
      required this.maghrib,
      required this.isha});

  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  @override
  String toString() {
    return 'fajr: $fajr, dhuhr: $dhuhr, asr: $asr, maghrib: $maghrib, isha: $isha  ';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [fajr, dhuhr, asr, maghrib, isha];
}
