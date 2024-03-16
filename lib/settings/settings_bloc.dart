import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salah_app/salah/view/salah_view.dart';
import 'package:salah_app/settings/data/settings_repository.dart';
import 'package:salah_app/settings/models/settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._settingsRepository)
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
            dhuhrOffset: 0,
            asrOffset: 0,
            maghribOffset: 0,
            ishaOffset: 0,
          ),
        ) {
    on<SettingsInitial>(_init);
    on<OffsetIncrement>(_offSetIncrement);
    on<OffsetDecrement>(_offSetDecrement);
  }

  final SettingsRepository _settingsRepository;

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
    await _settingsRepository.addOffset(event.prayerName);

    final settings = await _settingsRepository.init();
    emit(
      state.copyWith(
        status: SettingsStatus.success,
        asrOffset: settings!.asrOffset,
        dhuhrOffset: settings.dhuhrOffset,
        fajrOffset: settings.fajrOffset,
        ishaOffset: settings.ishaOffset,
        maghribOffset: settings.maghribOffset,
      ),
    );
  }
}

FutureOr<void> _offSetDecrement(
  OffsetDecrement event,
  Emitter<SettingsState> emit,
) {}
