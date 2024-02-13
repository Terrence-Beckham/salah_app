import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'salah_settings_event.dart';
part 'salah_settings_state.dart';

class SalahSettingsBloc extends Bloc<SalahSettingsEvent, SalahSettingsState> {
  SalahSettingsBloc() : super(SalahSettingsInitial()) {
    on<SalahSettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
