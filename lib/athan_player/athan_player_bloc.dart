import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'athan_player_event.dart';
part 'athan_player_state.dart';

class AthanPlayerBloc extends Bloc<AthanPlayerEvent, AthanPlayerState> {
  AthanPlayerBloc() : super(AthanPlayerInitial()) {
    on<AthanPlayerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
