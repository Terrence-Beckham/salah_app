import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/Data/timer_repository.dart';
import 'package:salah_app/salah/models/salah.dart';
import 'package:salah_repository/salah_repository.dart' hide SalahRepo;

part 'salah_state.dart';

class SalahCubit extends Cubit<SalahState> {
  SalahCubit(this._salahRepository, this._timerRepository)
      : super(const SalahState());

  // {_timerRepository.sendCurrentSalah()}

  final SalahRepository _salahRepository;
  final TimerRepository _timerRepository;
  final _logger = Logger();
  Timer? _timer;

  void startTimer(int initialSeconds) {
    // emit(state.copyWith(timeToNextSalah: initialSeconds));
    var elapsedTime = initialSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      var minutesLeft = (elapsedTime / 60).floor();
      final hoursLeft = minutesLeft ~/ 60;
      minutesLeft = minutesLeft - (hoursLeft * 60);
      elapsedTime -=1;



      _logger.i('time to next salah $minutesLeft ');
      emit(
        state.copyWith(
          status: SalahStatus.success,
          timeToNextSalah: state.timeToNextSalah - 1,
          minutesLeft:minutesLeft,
          hoursLeft: hoursLeft,
        ),
      );
      if (state.timeToNextSalah == 0) {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _logger.d('Timer has been cancelled');
  }

  @override
  Future<void> close() async {
    await super.close();
    _timer?.cancel(); // Ensure timer is cancelled on Cubit close
  }

  Future<void> fetchSalah() async {
    // if (city == null || city.isEmpty) return;
    emit(state.copyWith(status: SalahStatus.loading));
    // await _timerRepository.init();
    try {
      final salah = Salah.fromRepository(await _salahRepository.getSalah());
      _logger.d('this is the repository Salah $salah');
      final result = _timerRepository.getSalahTimeline(salah);
      final currentSalah = result.currentSalah;
      final nextSalah = result.nextSalah;
      final timeToNextSalah = result.timeToNextSalah;
      startTimer(timeToNextSalah);
      emit(
        state.copyWith(
          status: SalahStatus.success,
          salah: salah,
          currentSalah: currentSalah,
          nextSalah: nextSalah,
          timeToNextSalah: timeToNextSalah,
        ),
      );
      // startTimer(timeToNextSalah);
      // } catch (e) {
      //   _logger.e('the Exception is $e');
      // } finally {
      //   emit(state.copyWith(status: SalahStatus.failure));
      // }
    } on Exception {
      _logger.i(Exception().toString());
      emit(state.copyWith(status: SalahStatus.failure));
    }
  }
}
