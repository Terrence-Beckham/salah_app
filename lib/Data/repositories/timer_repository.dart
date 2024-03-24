import 'dart:async';

import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:salah_app/Data/repositories/settings_repository.dart';
import 'package:salah_app/salah/models/salah.dart';
import 'package:salah_app/salah/salah_bloc.dart';

class TimerRepository {
  TimerRepository({
    required Isar isarDb,
    required SettingsRepository settingsRepository,
  })  : _isar = isarDb,
        _settingsRepository = settingsRepository;

  final Isar _isar;
  final SettingsRepository _settingsRepository;
  final _logger = Logger();
  final Salah _salah = Salah.empty;
  late Timer _timer;
  final _salahStreamController = BehaviorSubject<Salah>.seeded(
    Salah.empty,
  );

  Stream<Salah> subscribeToTimeLines() =>
      _salahStreamController.asBroadcastStream();

  Future<Salah> getSalahTimeline(Salah salah) async {
    final settings = await _settingsRepository.init();
    final fajrOffset = settings!.fajrOffset;
    final sharooqOffset = settings.sharooqOffset;
    final dhuhrOffset = settings.dhuhrOffset;
    final asrOffset = settings.asrOffset;
    final maghribOffset = settings.maghribOffset;
    final ishaOffset = settings.ishaOffset;
    final newFormat = DateFormat('Hm');

    final fajrDateTime = DateFormat('dd-MM-yyyy HH:mm')
        .parse('${salah.gregorianDate} ${salah.fajrTime}');
    final fajrOffsetDateTime = fajrDateTime.add(Duration(minutes: fajrOffset));
    final fajrTime = newFormat.format(fajrDateTime);
    final fajrOffsetTime = newFormat.format(fajrOffsetDateTime);

    _logger
        .d('Fajr Time: $fajrDateTime' '\nFajr OffsetTime: $fajrOffsetDateTime');

    final sharooqDateTime = DateFormat('dd-MM-yyyy HH:mm')
        .parse('${salah.gregorianDate} ${salah.sharooqTime}');
    final sharooqOffsetDateTime =
        sharooqDateTime.add(Duration(minutes: sharooqOffset));
    final sharooqTime = newFormat.format(sharooqDateTime);
    final sharooqOffsetTime = newFormat.format(sharooqOffsetDateTime);
    _logger.i('Sharooq Time: $sharooqDateTime');

    final dhuhrDateTime = DateFormat('dd-MM-yyyy HH:mm')
        .parse('${salah.gregorianDate} ${salah.dhuhrTime}');
    final dhuhrOffsetDateTime =
        dhuhrDateTime.add(Duration(minutes: dhuhrOffset));
    final dhuhrTime = newFormat.format(dhuhrDateTime);
    final dhuhrOffsetTime = newFormat.format(dhuhrOffsetDateTime);

    _logger.i('Dhuhr Time: $dhuhrDateTime');

    final asrDateTime = DateFormat('dd-MM-yyyy HH:mm')
        .parse('${salah.gregorianDate} ${salah.asrTime}');
    final asrOffsetDateTime = asrDateTime.add(Duration(minutes: asrOffset));
    final asrTime = newFormat.format(asrDateTime);
    final asrOffsetTime = newFormat.format(asrOffsetDateTime);

    _logger.i('Asr Time: $asrDateTime');

    final maghribDateTime = DateFormat('dd-MM-yyyy HH:mm')
        .parse('${salah.gregorianDate} ${salah.maghribTime}');
    final maghribOffsetDateTime =
        maghribDateTime.add(Duration(minutes: maghribOffset));
    final maghribTime = newFormat.format(maghribDateTime);
    final maghribOffsetTime = newFormat.format(maghribOffsetDateTime);
    _logger.i('Maghrib Time: $maghribDateTime');

    final ishaDateTime = DateFormat('dd-MM-yyyy HH:mm')
        .parse('${salah.gregorianDate} ${salah.ishaTime}');
    final ishaOffsetDateTime = ishaDateTime.add(Duration(minutes: ishaOffset));
    final ishaTime = newFormat.format(ishaDateTime);
    final ishaOffsetTime = newFormat.format(ishaOffsetDateTime);

    _logger.i('Isha Time: $ishaDateTime');

    ///Todo break into another function here
    final now = DateTime.now();
    if (now.isAfter(fajrDateTime) && now.isBefore(sharooqDateTime)) {
      _logger.i(' Fajr prayer is the current prayer');
      final rightNow = DateTime.now();
      final timeToNextSalah =
          sharooqOffsetDateTime.difference(rightNow).inSeconds;
      return salah.copyWith(
        timeToNextSalah: timeToNextSalah,
        currentSalah: CurrentSalah.Fajr,
        nextSalah: NextSalah.Sharooq,
        fajrTime: fajrTime,
        fajrOffsetTime: fajrOffsetTime,
        sharooqTime: sharooqTime,
        sharooqOffsetTime: sharooqOffsetTime,
        dhuhrTime: dhuhrTime,
        dhuhrOffsetTime: dhuhrOffsetTime,
        asrTime: asrTime,
        asrOffsetTime: asrOffsetTime,
        maghribTime: maghribTime,
        maghribOffsetTime: maghribOffsetTime,
        ishaTime: ishaTime,
        ishaOffsetTime: ishaOffsetTime,
      );
    }
    if (now.isAfter(sharooqDateTime) && now.isBefore(dhuhrDateTime)) {
      _logger.i('Time is currently SharooqTime');
      final rightNow = DateTime.now();
      final timeToNextSalah = dhuhrDateTime.difference(rightNow).inSeconds;
      _logger.d(
        ' This should be the elapsed time between salah objects: $timeToNextSalah',
      );
      return salah.copyWith(
        timeToNextSalah: timeToNextSalah,
        currentSalah: CurrentSalah.Sharooq,
        nextSalah: NextSalah.Dhuhr,
        fajrTime: fajrTime,
        fajrOffsetTime: fajrOffsetTime,
        sharooqTime: sharooqTime,
        sharooqOffsetTime: sharooqOffsetTime,
        dhuhrTime: dhuhrTime,
        dhuhrOffsetTime: dhuhrOffsetTime,
        asrTime: asrTime,
        asrOffsetTime: asrOffsetTime,
        maghribTime: maghribTime,
        maghribOffsetTime: maghribOffsetTime,
        ishaTime: ishaTime,
        ishaOffsetTime: ishaOffsetTime,
      );
    }
    if (now.isAfter(dhuhrDateTime) && now.isBefore(asrDateTime)) {
      _logger.i(' Dhuhr prayer is the current prayer');
      final rightNow = DateTime.now();
      final timeToNextSalah = asrDateTime.difference(rightNow).inSeconds;
      _logger.i(
        'this is the time from right now until the Asr prayer $timeToNextSalah',
      );
      return salah.copyWith(
        timeToNextSalah: timeToNextSalah,
        currentSalah: CurrentSalah.Dhuhr,
        nextSalah: NextSalah.Asr,
        fajrTime: fajrTime,
        fajrOffsetTime: fajrOffsetTime,
        sharooqTime: sharooqTime,
        sharooqOffsetTime: sharooqOffsetTime,
        dhuhrTime: dhuhrTime,
        dhuhrOffsetTime: dhuhrOffsetTime,
        asrTime: asrTime,
        asrOffsetTime: asrOffsetTime,
        maghribTime: maghribTime,
        maghribOffsetTime: maghribOffsetTime,
        ishaTime: ishaTime,
        ishaOffsetTime: ishaOffsetTime,
      );
    }
    if (now.isAfter(asrDateTime) && now.isBefore(maghribDateTime)) {
      _logger.i(' Asr prayer is the current prayer');
      final rightNow = DateTime.now();
      final timeToNextSalah = maghribDateTime.difference(rightNow).inSeconds;
      _logger.d('this is the elapsed time I hope: $timeToNextSalah');
      return salah.copyWith(
        timeToNextSalah: timeToNextSalah,
        currentSalah: CurrentSalah.Asr,
        nextSalah: NextSalah.Maghrib,
        fajrTime: fajrTime,
        fajrOffsetTime: fajrOffsetTime,
        sharooqTime: sharooqTime,
        sharooqOffsetTime: sharooqOffsetTime,
        dhuhrTime: dhuhrTime,
        dhuhrOffsetTime: dhuhrOffsetTime,
        asrTime: asrTime,
        asrOffsetTime: asrOffsetTime,
        maghribTime: maghribTime,
        maghribOffsetTime: maghribOffsetTime,
        ishaTime: ishaTime,
        ishaOffsetTime: ishaOffsetTime,
      );
    }
    if (now.isAfter(maghribDateTime) && now.isBefore(ishaDateTime)) {
      _logger.i(' Maghrib prayer is the current prayer');
      final rightNow = DateTime.now();
      final timeToNextSalah = ishaDateTime.difference(rightNow).inSeconds;

      return salah.copyWith(
        timeToNextSalah: timeToNextSalah,
        currentSalah: CurrentSalah.Maghrib,
        nextSalah: NextSalah.Isha,
        fajrTime: fajrTime,
        fajrOffsetTime: fajrOffsetTime,
        sharooqTime: sharooqTime,
        sharooqOffsetTime: sharooqOffsetTime,
        dhuhrTime: dhuhrTime,
        dhuhrOffsetTime: dhuhrOffsetTime,
        asrTime: asrTime,
        asrOffsetTime: asrOffsetTime,
        maghribTime: maghribTime,
        maghribOffsetTime: maghribOffsetTime,
        ishaTime: ishaTime,
        ishaOffsetTime: ishaOffsetTime,
      );
    }
    // if(now.isAfter(ishaDateTime) && now.isBefore(fajrDateTime) ){
    if (now.isAfter(ishaDateTime)) {
      _logger.i(' Isha prayer is the current prayer');
      final rightNow = DateTime.now();
      final timeToNextSalah = fajrDateTime.difference(rightNow).inSeconds;
      // emit(state.copyWith(currentSalah: CurrentSalah.dhuhr));
      return salah.copyWith(
        timeToNextSalah: timeToNextSalah,
        currentSalah: CurrentSalah.Isha,
        nextSalah: NextSalah.Fajr,
        fajrTime: fajrTime,
        fajrOffsetTime: fajrOffsetTime,
        sharooqTime: sharooqTime,
        sharooqOffsetTime: sharooqOffsetTime,
        dhuhrTime: dhuhrTime,
        dhuhrOffsetTime: dhuhrOffsetTime,
        asrTime: asrTime,
        asrOffsetTime: asrOffsetTime,
        maghribTime: maghribTime,
        maghribOffsetTime: maghribOffsetTime,
        ishaTime: ishaTime,
        ishaOffsetTime: ishaOffsetTime,
      );
    }
    return salah.copyWith(
      timeToNextSalah: 0,
      currentSalah: CurrentSalah.unknown,
      nextSalah: NextSalah.unknown,
      fajrTime: fajrTime,
      fajrOffsetTime: fajrOffsetTime,
      sharooqTime: sharooqTime,
      sharooqOffsetTime: sharooqOffsetTime,
      dhuhrTime: dhuhrTime,
      dhuhrOffsetTime: dhuhrOffsetTime,
      asrTime: asrTime,
      asrOffsetTime: asrOffsetTime,
      maghribTime: maghribTime,
      maghribOffsetTime: maghribOffsetTime,
      ishaTime: ishaTime,
      ishaOffsetTime: ishaOffsetTime,
    );
  }

  void startTimer(Salah salah) {
    // emit(state.copyWith(timeToNextSalah: initialSeconds));
    _logger.i('Timer has started ');
    var elapsedTime = salah.timeToNextSalah;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final lastMinutes = (elapsedTime / 60).floor();
      final hoursLeft = lastMinutes ~/ 60;
      _logger.d('lastminutes: $lastMinutes,  lastHours: $hoursLeft');
      final minutesLeft = lastMinutes - (hoursLeft * 60);
      _logger.d('minutesLeft: $minutesLeft');
      elapsedTime -= 1;
      if (elapsedTime == 0 && salah.nextSalah != NextSalah.Sharooq) {
        cancelTimer();
        salah.copyWith(minutesLeft: minutesLeft, hoursLeft: hoursLeft);

        _logger
          ..i('timer is active = ${_timer.isActive}')
          ..i('$salah.hoursLeft, $minutesLeft');
        final localSalah = salah.copyWith(
          hoursLeft: hoursLeft,
          minutesLeft: minutesLeft,
          currentSalah: salah.currentSalah,
          timeToNextSalah: salah.timeToNextSalah,
          nextSalah: salah.nextSalah,
          fajrTime: salah.fajrTime,
          fajrOffsetTime: salah.fajrOffsetTime,
          sharooqTime: salah.sharooqTime,
          sharooqOffsetTime: salah.sharooqOffsetTime,
          dhuhrTime: salah.dhuhrTime,
          dhuhrOffsetTime: salah.dhuhrOffsetTime,
          asrTime: salah.asrTime,
          asrOffsetTime: salah.asrOffsetTime,
          maghribTime: salah.maghribTime,
          maghribOffsetTime: salah.maghribOffsetTime,
          ishaTime: salah.ishaTime,
          ishaOffsetTime: salah.ishaOffsetTime,
        );
        _salahStreamController.add(localSalah);
        _logger.d('The Athan should fire now');
      } else {
       final prayer = salah.copyWith(
          hoursLeft: hoursLeft,
          minutesLeft: minutesLeft,
          timeToNextSalah: elapsedTime,
          currentSalah: salah.currentSalah,
          nextSalah: salah.nextSalah,
          fajrTime: salah.fajrTime,
          fajrOffsetTime: salah.fajrOffsetTime,
          sharooqTime: salah.sharooqTime,
          sharooqOffsetTime: salah.sharooqOffsetTime,
          dhuhrTime: salah.dhuhrTime,
          dhuhrOffsetTime: salah.dhuhrOffsetTime,
          asrTime: salah.asrTime,
          asrOffsetTime: salah.asrOffsetTime,
          maghribTime: salah.maghribTime,
          maghribOffsetTime: salah.maghribOffsetTime,
          ishaTime: salah.ishaTime,
          ishaOffsetTime: salah.ishaOffsetTime,
        );
       _salahStreamController.add(prayer);
      }

      _logger.i('time to next salah $elapsedTime ');
    });
  }

  void cancelTimer() {
    _timer.cancel();
  }

  Future<void> addTimelineDataToTimer(Salah salah) async {
    final timelineObj = await getSalahTimeline(salah);
    startTimer(timelineObj);
  }
}
