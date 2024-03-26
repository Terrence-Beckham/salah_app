import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/Data/repositories/settings_repository.dart';
import 'package:salah_app/Data/repositories/timer_repository.dart';
import 'package:salah_app/salah/models/salah.dart';
import 'package:salah_app/salah/view/salah_view.dart';

import 'models/settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._salah, this._settingsRepository, this._timerRepository)
      : super(
          const SettingsState(
            salah: Salah.empty,
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
            method: 1,
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
          ),
        ) {
    on<SettingsInitial>(_init);
    on<OffsetIncrement>(_offSetIncrement);
    on<OffsetDecrement>(_offSetDecrement);
    on<UpdateSalahTimeDisplay>(_updateSalahTimeDisplay);
    // on<SalahTimeLineSubscription>(_subscribeToTimeline);
  }

  final Salah _salah;
  final SettingsRepository _settingsRepository;
  final TimerRepository _timerRepository;
  final Logger _logger = Logger();

  Future<void> _init(SettingsInitial event, Emitter<SettingsState> emit) async {
    final settings = await _settingsRepository.init();
    _logger.e('Fajr offset Display: ${settings?.fajrOffsetDisplay}');
    emit(
      state.copyWith(
        status: SettingsStatus.success,
        salah: _salah,
        fajrOffset: settings?.fajrOffsetDisplay,
        sharooqOffset: settings?.sharooqOffsetDisplay,
        dhuhrOffset: settings?.dhuhrOffsetDisplay,
        asrOffset: settings?.asrOffsetDisplay,
        maghribOffset: settings?.maghribOffsetDisplay,
        ishaOffset: settings?.ishaOffsetDisplay,
      ),
    );
  }

  FutureOr<void> _offSetIncrement(
    OffsetIncrement event,
    Emitter<SettingsState> emit,
  ) async {
    await _settingsRepository.updateIncrementOffset(event.prayerName);

    final settings = await _settingsRepository.init();
    final tempSalah = await _timerRepository.getSalahTimeline(event.salah);
    _logger.e('tempSalah: $tempSalah');

    emit(
      state.copyWith(
        fajrOffset: settings?.fajrOffsetDisplay,
        sharooqOffset: settings?.sharooqOffsetDisplay,
        dhuhrOffset: settings?.dhuhrOffsetDisplay,
        asrOffset: settings?.asrOffsetDisplay,
        maghribOffset: settings?.maghribOffsetDisplay,
        ishaOffset: settings?.ishaOffsetDisplay,
        salah: tempSalah,
        status: SettingsStatus.success,
      ),
    );
  }

  FutureOr<void> _offSetDecrement(
    OffsetDecrement event,
    Emitter<SettingsState> emit,
  ) async {
    await _settingsRepository.updateDecrementOffset(event.prayerName);
    final settings = await _settingsRepository.init();
    final tempSalah = await _timerRepository.getSalahTimeline(event.salah);
    emit(
      state.copyWith(
        fajrOffset: settings?.fajrOffsetDisplay,
        sharooqOffset: settings?.sharooqOffsetDisplay,
        dhuhrOffset: settings?.dhuhrOffsetDisplay,
        asrOffset: settings?.asrOffsetDisplay,
        maghribOffset: settings?.maghribOffsetDisplay,
        ishaOffset: settings?.ishaOffsetDisplay,
        salah: tempSalah,
        status: SettingsStatus.success,
      ),
    );
  }

  FutureOr<void> _updateSalahTimeDisplay(
    UpdateSalahTimeDisplay event,
    Emitter<SettingsState> emit,
  ) async {
    final tempSalah = event.salah;
    final salah = await _timerRepository.getSalahTimeline(tempSalah);
    emit(state.copyWith(status: SettingsStatus.success, salah: salah));
  }
}
