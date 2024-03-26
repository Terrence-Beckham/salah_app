import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/Data/repositories/settings_repository.dart';
import 'package:salah_app/Data/repositories/timer_repository.dart';
import 'package:salah_app/salah/models/salah.dart';
import 'package:salah_repository/salah_repository.dart';

part 'salah_event.dart';
part 'salah_state.dart';

class SalahBloc extends Bloc<SalahEvent, SalahState> {
  SalahBloc(
    this._salahRepository,
    this._timerRepository,
    this._settingsRepository,
  ) : super(
          const SalahState(
            salah: Salah.empty,
            status: SalahStatus.initial,
          ),
        ) {
    on<SalahInitial>(_initSalah);
    on<SubscribeToTimeline>(_subscribeTimeline);
    on<RequestSalah>(_requestSalah);
    on<InitializeSettings>(_initSettings);
  }

  final SalahRepository _salahRepository;
  final TimerRepository _timerRepository;
  final SettingsRepository _settingsRepository;

  final _logger = Logger();

  void _initSalah(SalahInitial event, Emitter<SalahState> emit) {
    emit(state.copyWith(status: SalahStatus.loading));
    add(const RequestSalah());
  }

  Future<void> _requestSalah(
    RequestSalah event,
    Emitter<SalahState> emit,
  ) async {
    try {
      var salah = Salah.fromRepository(await _salahRepository.getSalah());
      _logger.i('current City is  ${salah.city} I think');
      salah = await _timerRepository.getSalahTimeline(salah);
      // _timerRepository.cancelTimer();
      await _timerRepository.addTimelineDataToTimer(salah);
      emit(state.copyWith(status: SalahStatus.loading));
      add(SubscribeToTimeline(salah));
    } on Exception {
      emit(state.copyWith(status: SalahStatus.failure));
      _logger.i(Exception().toString());
    }
  }

  Future<void> _initSettings(
    InitializeSettings event,
    Emitter<SalahState> emitter,
  ) async {
    await _settingsRepository.init();
  }

  FutureOr<void> _subscribeTimeline(
    SubscribeToTimeline event,
    Emitter<SalahState> emit,
  ) async {
    await emit.forEach<Salah>(
      _timerRepository.subscribeToTimeLines(),
      onData: (data) {
        _logger.d(data);

        return state.copyWith(
          status: SalahStatus.success,
          salah: data,
        );
      },
    );
  }
}
