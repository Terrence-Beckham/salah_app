import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/salah/cubit/salah_cubit.dart';
import 'package:salah_app/salah/models/salah.dart';

@override
class TimerRepository extends StatelessWidget {
  TimerRepository({super.key});

  final _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Stream<CurrentSalah> getCurrentSalah() async*{
   ///Todo setup Timer duration to fire when the time for one Salah has ended and
    // another has begun

  }

  CurrentSalah getSalahDate(Salah salah) {
    final dateString = salah.gregorianDate;
    final fajrDateTime = DateFormat('dd-MM-yyyy hh:mm')
        .parse('${salah.gregorianDate} ${salah.fajr}');
    final sharooqDateTime = DateFormat('dd-MM-yyyy hh:mm')
        .parse('${salah.gregorianDate} ${salah.sharooq}');
    final dhuhrDateTime = DateFormat('dd-MM-yyyy hh:mm')
        .parse('${salah.gregorianDate} ${salah.dhuhr}');
    final asrDateTime = DateFormat('dd-MM-yyyy hh:mm')
        .parse('${salah.gregorianDate} ${salah.asr}');
    final maghribDateTime = DateFormat('dd-MM-yyyy hh:mm')
        .parse('${salah.gregorianDate} ${salah.maghrib}');
    final ishaDateTime = DateFormat('dd-MM-yyyy hh:mm')
        .parse('${salah.gregorianDate} ${salah.isha}');
    // DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse("2023-08-10 08:32:05);
    _logger
      ..i('This is the fajr datetime object: $fajrDateTime')
      ..i(dateString);

    final now = DateTime.now();

    if (now.isAfter(fajrDateTime) && now.isBefore(sharooqDateTime)) {
      _logger.i(' Fajr prayer is the current prayer');
      return CurrentSalah.fajr;
      // emit(state.copyWith(currentSalah: CurrentSalah.fajr));
    }
    if (now.isAfter(sharooqDateTime) && now.isBefore(dhuhrDateTime)) {
      _logger.i('Time is currently SharooqTime');
      // emit(state.copyWith(currentSalah: CurrentSalah.sharooq));
      return CurrentSalah.sharooq;
    }
    if (now.isAfter(dhuhrDateTime) && now.isBefore(asrDateTime)) {
      _logger.i(' Dhuhr prayer is the current prayer');
      // emit(state.copyWith(currentSalah: CurrentSalah.dhuhr));
      return CurrentSalah.dhuhr;
    }
    if (now.isAfter(asrDateTime) && now.isBefore(maghribDateTime)) {
      _logger.i(' Asr prayer is the current prayer');
      // emit(state.copyWith(currentSalah: CurrentSalah.asr));
      return CurrentSalah.asr;
    }
    if (now.isAfter(maghribDateTime) && now.isBefore(ishaDateTime)) {
      _logger.i(' Maghrib prayer is the current prayer');
      // emit(state.copyWith(currentSalah: CurrentSalah.maghrib));
      return CurrentSalah.maghrib;
    }
    // if(now.isAfter(ishaDateTime) && now.isBefore(fajrDateTime) ){
    if (now.isAfter(ishaDateTime)) {
      _logger.i(' Isha prayer is the current prayer');
      // emit(state.copyWith(currentSalah: CurrentSalah.isha));
      return CurrentSalah.isha;
    }
    return  CurrentSalah.unknown;
  }
}
