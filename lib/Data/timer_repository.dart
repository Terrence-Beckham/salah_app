import 'dart:async';

import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta_meta.dart';
import 'package:rxdart/subjects.dart';
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
  final _timeLineDataStreamController = BehaviorSubject<TimelineData>.seeded(
    TimelineData(
      timeToNextSalah: 0,
      nextSalah: NextSalah.unknown,
      currentSalah: CurrentSalah.unknown,
      hoursLeft: 0,
      minutesLeft: 0,
    ),
  );

  Stream<TimelineData> getTimeLines() =>
      _timeLineDataStreamController.asBroadcastStream();

  Future<Salah?> retrieveSalah() async {
    final formatedTime = DateFormat('dd-MM-yyyy').format(DateTime.now());

    final salah = await _isar.salahRepos
        .filter()
        .gregorianDateMatches(formatedTime)
        .findFirst();
    _logger.i('this is the salah from the db for today $salah');
    final localSalah = Salah.fromRepository(salah!);
    return localSalah;
  }

  void startTimer(TimelineData timelineData) {
    // emit(state.copyWith(timeToNextSalah: initialSeconds));
    var elapsedTime = timelineData.timeToNextSalah;
    _timer = Timer.periodic(const Duration(seconds: 60), (_) {
      final lastMinutes = (elapsedTime / 60).floor();
      final hoursLeft = lastMinutes ~/ 60;
      final minutesLeft = lastMinutes - (hoursLeft * 60);
      elapsedTime -= 60;
      final timelineOb = TimelineData(
        timeToNextSalah: elapsedTime,
        currentSalah: timelineData.currentSalah,
        nextSalah: timelineData.nextSalah,
        minutesLeft: minutesLeft,
        hoursLeft: hoursLeft,
      );
      _timeLineDataStreamController.add(timelineOb);

      _logger.i('time to next salah $elapsedTime ');
      if (elapsedTime == 0) {
        final timelineObject = TimelineData(
          isAthanTime: true,
          currentSalah: timelineData.currentSalah,
          timeToNextSalah: timelineData.timeToNextSalah,
          nextSalah: timelineData.nextSalah,
        );
        _timeLineDataStreamController.add(timelineObject);
        _logger.d('The Athan should fire now');
      }
    });
  }

  TimelineData getSalahTimeline(Salah salah) {
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

    final now = DateTime.now();
    if (now.isAfter(fajrDateTime) && now.isBefore(sharooqDateTime)) {
      _logger.i(' Fajr prayer is the current prayer');
      final rightNow = DateTime.now();
      final timeToNextSalah = sharooqDateTime.difference(rightNow).inSeconds;
      final timelineObj = TimelineData(
        timeToNextSalah: timeToNextSalah,
        currentSalah: CurrentSalah.Fajr,
        nextSalah: NextSalah.Sharooq,
      );

      startTimer(timelineObj);
      // emit(state.copyWith(currentSalah: CurrentSalah.fajr));
    }
    if (now.isAfter(sharooqDateTime) && now.isBefore(dhuhrDateTime)) {
      _logger.i('Time is currently SharooqTime');
      final rightNow = DateTime.now();
      final timeToNextSalah = dhuhrDateTime.difference(rightNow).inSeconds;
      _logger.d(
        ' This should be the elapsed time between salah objects: $timeToNextSalah',
      );
      final timelineObj = TimelineData(
        timeToNextSalah: timeToNextSalah,
        currentSalah: CurrentSalah.Sharooq,
        nextSalah: NextSalah.Dhuhr,
      );
      startTimer(timelineObj);
      return timelineObj;
    }
    if (now.isAfter(dhuhrDateTime) && now.isBefore(asrDateTime)) {
      _logger.i(' Dhuhr prayer is the current prayer');
      final rightNow = DateTime.now();
      final timeToNextSalah = asrDateTime.difference(rightNow).inSeconds;
      _logger.i(
          'this is the time from right now until the Asr prayer $timeToNextSalah');
      final timelineObj = TimelineData(
        timeToNextSalah: timeToNextSalah,
        currentSalah: CurrentSalah.Dhuhr,
        nextSalah: NextSalah.Asr,
      );
      startTimer(timelineObj);
      return timelineObj;
    }
    if (now.isAfter(asrDateTime) && now.isBefore(maghribDateTime)) {
      _logger.i(' Asr prayer is the current prayer');
      final rightNow = DateTime.now();
      final timeToNextSalah = maghribDateTime.difference(rightNow).inSeconds;
      _logger.d('this is the elapsed time I hope: $timeToNextSalah');
      final timelineObj = TimelineData(
        timeToNextSalah: timeToNextSalah,
        currentSalah: CurrentSalah.Asr,
        nextSalah: NextSalah.Maghrib,
      );
      startTimer(timelineObj);
      return timelineObj;
      // emit(state.copyWith(currentSalah: CurrentSalah.asr));
    }
    if (now.isAfter(maghribDateTime) && now.isBefore(ishaDateTime)) {
      _logger.i(' Maghrib prayer is the current prayer');
      final rightNow = DateTime.now();
      final timeToNextSalah = ishaDateTime.difference(rightNow).inSeconds;

      final timelineObj = TimelineData(
        timeToNextSalah: timeToNextSalah,
        currentSalah: CurrentSalah.Maghrib,
        nextSalah: NextSalah.Isha,
      );
      startTimer(timelineObj);
      return timelineObj;
    }
    // if(now.isAfter(ishaDateTime) && now.isBefore(fajrDateTime) ){
    if (now.isAfter(ishaDateTime)) {
      _logger.i(' Isha prayer is the current prayer');
      final rightNow = DateTime.now();
      final timeToNextSalah = fajrDateTime.difference(rightNow).inSeconds;
      // emit(state.copyWith(currentSalah: CurrentSalah.dhuhr));
      final timelineObj = TimelineData(
        timeToNextSalah: timeToNextSalah,
        currentSalah: CurrentSalah.Isha,
        nextSalah: NextSalah.Fajr,
      );
      startTimer(timelineObj);
      return timelineObj;
    }
    return TimelineData(
      timeToNextSalah: 0,
      currentSalah: CurrentSalah.unknown,
      nextSalah: NextSalah.unknown,
    );
  }
}

class TimelineData {
  TimelineData({
    required this.timeToNextSalah,
    required this.currentSalah,
    required this.nextSalah,
    this.hoursLeft,
    this.minutesLeft,
    this.isAthanTime = false,
  });

  final int timeToNextSalah;
  final CurrentSalah currentSalah;
  final NextSalah nextSalah;
  final int? hoursLeft;
  final bool isAthanTime;

  final int? minutesLeft;

  TimelineData copyWith({
    int? timeToNextSalah,
    CurrentSalah? currentSalah,
    NextSalah? nextSalah,
    int? hoursLeft,
    bool isAthanTime = false,
    int? minutesLeft,
  }) {
    return TimelineData(
      currentSalah: currentSalah ?? this.currentSalah,
      nextSalah: nextSalah ?? this.nextSalah,
      hoursLeft: hoursLeft ?? this.hoursLeft,
      isAthanTime: isAthanTime,
      minutesLeft: minutesLeft ?? this.minutesLeft,
      timeToNextSalah: timeToNextSalah ?? this.timeToNextSalah,
    );
  }
}
