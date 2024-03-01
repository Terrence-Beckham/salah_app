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
  CurrentSalah _currentSalah = CurrentSalah.unknown;
  NextSalah _nextSalah = NextSalah.unknown;
  late Timer _timer;

  Stream<CurrentSalah> getCurrentSalah() async* {
    ///Todo setup Timer duration to fire when the time for one Salah has ended and
    // another has begun
  }

  Future<void> init() async {
    final tempSalah = await retrieveSalah();
    final result = getSalahTimeline(tempSalah!);
    // final nextSalah = result[0],currentSalah;
    _currentSalah = result.$1;
    _nextSalah = result.$2;
    _logger
      ..i('This is the currentSalah $_currentSalah')
      ..i('This is the NextSalah $_nextSalah');
    // return(_currentSalah, _nextSalah);
  }

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

  (CurrentSalah, NextSalah) getSalahTimeline(Salah salah) {
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
      final diff = fajrDateTime.difference(sharooqDateTime);
      _logger.i('This is the time difference between fajr and Sharooq: $diff');
      return (CurrentSalah.Fajr, NextSalah.Sharooq);
      // emit(state.copyWith(currentSalah: CurrentSalah.fajr));
    }
    if (now.isAfter(sharooqDateTime) && now.isBefore(dhuhrDateTime)) {
      _logger.i('Time is currently SharooqTime');
      // emit(state.copyWith(currentSalah: CurrentSalah.sharooq));
      return (CurrentSalah.Sharooq, NextSalah.Dhuhr);
    }
    if (now.isAfter(dhuhrDateTime) && now.isBefore(asrDateTime)) {
      _logger.i(' Dhuhr prayer is the current prayer');
      // emit(state.copyWith(currentSalah: CurrentSalah.dhuhr));
      return (CurrentSalah.Dhuhr, NextSalah.Asr);
    }
    if (now.isAfter(asrDateTime) && now.isBefore(maghribDateTime)) {
      _logger.i(' Asr prayer is the current prayer');
      // emit(state.copyWith(currentSalah: CurrentSalah.asr));
      return (CurrentSalah.Asr, NextSalah.Maghrib);
    }
    if (now.isAfter(maghribDateTime) && now.isBefore(ishaDateTime)) {
      _logger.i(' Maghrib prayer is the current prayer');
      final diff = maghribDateTime.difference(ishaDateTime);
      _logger.i('This is the time difference between Maghrib and Isha: $diff');
      // emit(state.copyWith(currentSalah: CurrentSalah.maghrib));
      return (CurrentSalah.Maghrib, NextSalah.Isha);
    }
    // if(now.isAfter(ishaDateTime) && now.isBefore(fajrDateTime) ){
    if (now.isAfter(ishaDateTime)) {
      _logger.i(' Isha prayer is the current prayer');
      // emit(state.copyWith(currentSalah: CurrentSalah.isha));
      //TODO this has to be modified to use the next day's fajr prayer
      return (CurrentSalah.Isha, NextSalah.Fajr);
    }
    return (CurrentSalah.unknown, NextSalah.unknown);
  }

  void startTimer(Duration diff) {
    _timer = Timer(diff, () {});
  }
}
