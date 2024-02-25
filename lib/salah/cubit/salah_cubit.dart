import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/salah/models/salah.dart';
import 'package:salah_repository/salah_repository.dart' hide SalahRepo;

part 'salah_state.dart';

class SalahCubit extends Cubit<SalahState> {
  SalahCubit(this._salahRepository) : super(const SalahState());
  final SalahRepository _salahRepository;

  final _logger = Logger();

  initTimer(Salah salah) {

  }

  Future<void> fetchSalah() async {
    // if (city == null || city.isEmpty) return;
    emit(state.copyWith(status: SalahStatus.loading));
    try {
      final salah = Salah.fromRepository(await _salahRepository.getSalah());

      emit(
        state.copyWith(
          status: SalahStatus.success,
          salah: salah,
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
