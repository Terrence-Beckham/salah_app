import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/salah/cubit/salah_cubit.dart';
import 'package:salah_app/salah/models/salah.dart';
import 'package:salah_repository/salah_repository.dart';

class TimerRepository {
  TimerRepository({
    required Isar isarDb,
  }) : _isar = isarDb;

  final Isar _isar;
  final _logger = Logger();
  final Salah _salah = Salah.empty;
  late Timer _timer;

  Future<Salah?> retrieveSalah() async {
    // final formatedTime = DateFormat.yMMMd().format(DateTime.now());
    final formatedTime = DateFormat('dd-MM-yyyy').format(DateTime.now());

    final salah = await _isar.salahRepos
        .filter()
        .gregorianDateMatches(formatedTime)
        .findFirst();
    _logger.i('this is the salah from the db for today $salah');
    final localSalah = Salah.fromRepository(salah!);
    return localSalah;
  }

  ({CurrentSalah currentSalah, NextSalah nextSalah, int timeToNextSalah})
      getSalahTimeline(Salah salah) {
    final fajrDateTime = DateFormat('dd-MM-yyyy HH:mm')
        .parse('${salah.gregorianDate} ${salah.fajr}');
    _logger.i('Fajr Time: $fajrDateTime');
    final sharooqDateTime = DateFormat('dd-MM-yyyy HH:mm')
        .parse('${salah.gregorianDate} ${salah.sharooq}');
    _logger.i('Sharooq Time: $sharooqDateTime');
    final dhuhrDateTime = DateFormat('dd-MM-yyyy HH:mm')
        .parse('${salah.gregorianDate} ${salah.dhuhr}');
    _logger.i('Dhuhr Time: $dhuhrDateTime');
    final asrDateTime = DateFormat('dd-MM-yyyy HH:mm')
        .parse('${salah.gregorianDate} ${salah.asr}');
    _logger.i('Asr Time: $asrDateTime');
    final maghribDateTime = DateFormat('dd-MM-yyyy HH:mm')
        .parse('${salah.gregorianDate} ${salah.maghrib}');
    _logger.i('Maghrib Time: $maghribDateTime');
    final ishaDateTime = DateFormat('dd-MM-yyyy HH:mm')
        .parse('${salah.gregorianDate} ${salah.isha}');
    _logger.i('Isha Time: $ishaDateTime');
    // DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse("2023-08-10 08:32:05);

    final now = DateTime.now();
    if (now.isAfter(fajrDateTime) && now.isBefore(sharooqDateTime)) {
      _logger.i(' Fajr prayer is the current prayer');
      final rightNow = DateTime.now();
      final timeToNextSalah = sharooqDateTime.difference(rightNow).inSeconds;

      return (
        currentSalah: CurrentSalah.Fajr,
        nextSalah: NextSalah.Sharooq,
        timeToNextSalah: timeToNextSalah
      );
      // emit(state.copyWith(currentSalah: CurrentSalah.fajr));
    }
    if (now.isAfter(sharooqDateTime) && now.isBefore(dhuhrDateTime)) {
      _logger.i('Time is currently SharooqTime');
      final rightNow = DateTime.now();
      final timeToNextSalah = dhuhrDateTime.difference(rightNow).inSeconds;
      return (
        currentSalah: CurrentSalah.Sharooq,
        nextSalah: NextSalah.Dhuhr,
        timeToNextSalah: timeToNextSalah
      );
    }
    if (now.isAfter(dhuhrDateTime) && now.isBefore(asrDateTime)) {
      _logger.i(' Dhuhr prayer is the current prayer');
      final timeToNextSalah = asrDateTime.difference(dhuhrDateTime).inSeconds;
      // emit(state.copyWith(currentSalah: CurrentSalah.dhuhr));
      return (
        currentSalah: CurrentSalah.Dhuhr,
        nextSalah: NextSalah.Asr,
        timeToNextSalah: timeToNextSalah
      );
    }
    if (now.isAfter(asrDateTime) && now.isBefore(maghribDateTime)) {
      _logger.i(' Asr prayer is the current prayer');
      final rightNow = DateTime.now();
      final timeToNextSalah = maghribDateTime.difference(rightNow).inSeconds;
      _logger.d('this is the elapsed time I hope: $timeToNextSalah');
      return (
        currentSalah: CurrentSalah.Asr,
        nextSalah: NextSalah.Maghrib,
        timeToNextSalah: timeToNextSalah
      );
      // emit(state.copyWith(currentSalah: CurrentSalah.asr));
    }
    if (now.isAfter(maghribDateTime) && now.isBefore(ishaDateTime)) {
      _logger.i(' Maghrib prayer is the current prayer');
      final rightNow = DateTime.now();
      final timeToNextSalah = ishaDateTime.difference(rightNow).inSeconds;
      // emit(state.copyWith(currentSalah: CurrentSalah.dhuhr));
      return (
        currentSalah: CurrentSalah.Maghrib,
        nextSalah: NextSalah.Isha,
        timeToNextSalah: timeToNextSalah
      );
    }
    // if(now.isAfter(ishaDateTime) && now.isBefore(fajrDateTime) ){
    if (now.isAfter(ishaDateTime)) {
      _logger.i(' Isha prayer is the current prayer');
      final timeToNextSalah = fajrDateTime.difference(ishaDateTime).inSeconds;
      // emit(state.copyWith(currentSalah: CurrentSalah.dhuhr));
      return (
        currentSalah: CurrentSalah.Isha,
        nextSalah: NextSalah.Fajr,
        timeToNextSalah: timeToNextSalah
      );
    }
    return (
      currentSalah: CurrentSalah.unknown,
      nextSalah: NextSalah.unknown,
      timeToNextSalah: 1000
    );
  }
}
