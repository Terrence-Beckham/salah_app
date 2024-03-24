import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/Data/repositories/models/timeline_data.dart';
import 'package:salah_app/Data/repositories/settings_repository.dart';
import 'package:salah_app/Data/repositories/timer_repository.dart';
import 'package:salah_app/salah/models/salah.dart';
import 'package:salah_app/salah/view/salah_view.dart';
import 'package:salah_app/settings/models/settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._settingsRepository, this._timerRepository)
      : super(
          const SettingsState(
            method: null,
            language: '',
            name: '',
            fajrAthan: '',
            regularAthan: '',
            juristicSchool: JuristicSchool.standard,
            fajrAthanSettings: AthanSoundSettings.sound,
            dhuhrAthanSettings: AthanSoundSettings.sound,
            asrAthanSettings: AthanSoundSettings.sound,
            maghribAthanSettings: AthanSoundSettings.sound,
            ishaAthanSettings: AthanSoundSettings.sound,
            fajrOffset: 0,
            sharooqOffset: 0,
            dhuhrOffset: 0,
            asrOffset: 0,
            maghribOffset: 0,
            ishaOffset: 0,
            fajrTime: '',
            fajrOffsetTime: '',
            sharooqTime: '',
            sharooqOffsetTime: '',
            dhuhrTime: '',
            dhuhrOffsetTime: '',
            asrTime: '',
            asrOffsetTime: '',
            maghribTime: '',
            maghribOffsetTime: '',
            ishaTime: '',
            ishaOffsetTime: '',
          ),
        ) {
    on<SettingsInitial>(_init);
    on<OffsetIncrement>(_offSetIncrement);
    on<OffsetDecrement>(_offSetDecrement);
    // on<SalahTimeLineSubscription>(_subscribeToTimeline);
  }

  final SettingsRepository _settingsRepository;
  final TimerRepository _timerRepository;
  final Logger _logger = Logger();

  Future<void> _init(SettingsInitial event, Emitter<SettingsState> emit) async {
    emit(
      state.copyWith(
        status: SettingsStatus.loading,
      ),
    );
    final settings = await _settingsRepository.init();
    emit(
      state.copyWith(
        status: SettingsStatus.success,
        asrAthanSettings: settings!.asrAthanSoundSettings,
        asrOffset: settings.asrOffset,
        dhuhrAthanSettings: settings.dhuhrAthanSoundSettings,
        dhuhrOffset: settings.dhuhrOffset,
        fajrAthan: settings.fajrAthan,
        fajrAthanSettings: settings.fajrAthanSoundsSettings,
        fajrOffset: settings.fajrOffset,
        sharooqOffset: settings.sharooqOffset,
        ishaAthanSettings: settings.ishaAthanSoundSettings,
        ishaOffset: settings.ishaOffset,
        juristicSchool: settings.juristicSchool,
        language: settings.language,
        maghribAthanSettings: settings.maghribAthanSoundSettings,
        maghribOffset: settings.maghribOffset,
        method: settings.method,
        name: settings.name,
        regularAthan: settings.regularAthan,
      ),
    );
  }

  FutureOr<void> _offSetIncrement(
    OffsetIncrement event,
    Emitter<SettingsState> emit,
  ) async {
    await _settingsRepository.updateIncrementOffset(event.prayerName);

    final settings = await _settingsRepository.init();
    emit(
      state.copyWith(
        status: SettingsStatus.success,
        asrOffset: settings!.asrOffset,
        dhuhrOffset: settings.dhuhrOffset,
        fajrOffset: settings.fajrOffset,
        sharooqOffset: settings.sharooqOffset,
        ishaOffset: settings.ishaOffset,
        maghribOffset: settings.maghribOffset,
      ),
    );
  }

  FutureOr<void> _offSetDecrement(
      OffsetDecrement event, Emitter<SettingsState> emit) async {
    await _settingsRepository.updateDecrementOffset(event.prayerName);

    final settings = await _settingsRepository.init();
    emit(
      state.copyWith(
        status: SettingsStatus.success,
        asrOffset: settings!.asrOffset,
        dhuhrOffset: settings.dhuhrOffset,
        fajrOffset: settings.fajrOffset,
        sharooqOffset: settings.sharooqOffset,
        ishaOffset: settings.ishaOffset,
        maghribOffset: settings.maghribOffset,
      ),
    );
  }

  // FutureOr<void> _subscribeToTimeline(
  //   SalahTimeLineSubscription event,
  //   Emitter<SettingsState> emit,
  // ) async {
  //   await _timerRepository.getSalahTimeline(event._salah);
  //   await emit.forEach<TimelineData>(
  //     _timerRepositor,
  //     onData: (data) {
  //      _logger.d('this is the data from the prayerStream $data' );
  //       return state.copyWith(
  //         status: SettingsStatus.success,
  //         fajrTime: data.fajrTime,
  //         fajrOffsetTime: data.fajrOffsetTime,
  //         sharooqOffsetTime: data.sharooqOffsetTime,
  //         sharooqTime: data.sharooqTime,
  //         dhuhrTime: data.dhuhrTime,
  //         dhuhrOffsetTime: data.dhuhrOffsetTime,
  //         asrTime: data.asrTime,
  //         asrOffsetTime: data.asrOffsetTime,
  //         maghribTime: data.maghribTime,
  //         maghribOffsetTime: data.maghribOffsetTime,
  //         ishaTime: data.ishaTime,
  //         ishaOffsetTime: data.ishaOffsetTime,
  //       );
  //     },
  //   );
  // }
}
