import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/Data/timer_repository.dart';
import 'package:salah_app/salah/models/salah.dart';
import 'package:salah_repository/salah_repository.dart';

part 'salah_event.dart';

part 'salah_state.dart';

class SalahBloc extends Bloc<SalahEvent, SalahState> {
  SalahBloc(this._salahRepository, this._timerRepository)
      : super(
          const SalahState(
            salah: Salah.empty,
            hoursLeft: 0,
            minutesLeft: 0,
            currentSalah: CurrentSalah.unknown,
            nextSalah: NextSalah.unknown,
            timeToNextSalah: 0,
          ),
        ) {
    on<SalahInitial>(_initSalah);
    on<SubscribeToTimeline>(subscribeTimeline);
    on<RequestSalah>(_requestSalah);
  }

  final SalahRepository _salahRepository;
  final TimerRepository _timerRepository;
  final _logger = Logger();

  void _initSalah(SalahInitial event, Emitter<SalahState> emit) {
    emit(state.copyWith(status: () => SalahStatus.loading));
    add(const RequestSalah());
  }

  Future<void> _requestSalah(
    RequestSalah event,
    Emitter<SalahState> emit,
  ) async {
    try {
      final salah = Salah.fromRepository(await _salahRepository.getSalah());
      _logger.i('current Salah is  ${salah.city} I think');
      _timerRepository.getSalahTimeline(salah);
      emit(state.copyWith(salah: () => salah));
      add(SubscribeToTimeline(salah));
    } on Exception {
      emit(state.copyWith(status: () => SalahStatus.failure));
      _logger.i(Exception().toString());
    }
  }

  FutureOr<void> subscribeTimeline(
    SubscribeToTimeline event,
    Emitter<SalahState> emit,
  ) async {
    await emit.forEach<TimelineData>(
      _timerRepository.subscribeToTimeLines(),
      onData: (data) {
        if (data.isAthanTime) {
          return state.copyWith(
            status: () => SalahStatus.athanPlaying,
            minutesLeft: () => data.minutesLeft,
            timeToNextSalah: () => data.timeToNextSalah,
            nextSalah: () => data.nextSalah,
            currentSalah: () => data.currentSalah,
            hoursLeft: () => data.hoursLeft,
            isAthanTime: () => data.isAthanTime,
          );
        } else {
          return state.copyWith(
            status: () => SalahStatus.success,
            minutesLeft: () => data.minutesLeft,
            timeToNextSalah: () => data.timeToNextSalah,
            nextSalah: () => data.nextSalah,
            currentSalah: () => data.currentSalah,
            hoursLeft: () => data.hoursLeft,
            isAthanTime: () => data.isAthanTime,
          );
        }
      },
    );
  }
}
