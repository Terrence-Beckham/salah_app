import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/Data/timer_repository.dart';
import 'package:salah_app/salah/models/salah.dart';
import 'package:salah_repository/salah_repository.dart' hide SalahRepo;

part 'salah_state.dart';

class SalahCubit extends Cubit<SalahState> {
  SalahCubit(this._salahRepository, this._timerRepository)
      : super(const SalahState());
  final SalahRepository _salahRepository;
  final TimerRepository _timerRepository;
  final _logger = Logger();

  initTimer(Salah salah) {}

  Future<void> fetchSalah() async {
    // if (city == null || city.isEmpty) return;
    emit(state.copyWith(status: SalahStatus.loading));
    await _timerRepository.init();

    try {
      final salah = Salah.fromRepository(await _salahRepository.getSalah());
      final result = _timerRepository.getSalahTimeline(salah);
      final currentSalah = result.$1;
      final nextSalah = result.$2;
      // _getSalahDate(salah);

      emit(
        state.copyWith(
          status: SalahStatus.success,
          salah: salah,
          currentSalah: currentSalah,
          nextSalah: nextSalah,
        ),
      );
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
