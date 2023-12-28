import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/salah/models/salah.dart';
import 'package:salah_repository/salah_repository.dart' hide Salah;

part 'salah_cubit.g.dart';
part 'salah_state.dart';

class SalahCubit extends Cubit<SalahState> {
  SalahCubit(this._salahRepository) : super(const SalahState());
  final SalahRepository _salahRepository;

  final _logger = Logger();

  Future<void> fetchSalah(String city) async {
    if (city == null || city.isEmpty) return;
    emit(state.copyWith(status: SalahStatus.loading));

    try {
      final salah = Salah.fromRepository(await _salahRepository.getSalah(city));
      emit(
        state.copyWith(
          status: SalahStatus.success,
          salah: salah,
        ),
      );
    } catch (e) {
      _logger.e('the Exception is $e');
    } finally {
      emit(state.copyWith(status: SalahStatus.failure));
    }
    // } on Exception {
    //   _logger.i(Exception().toString());
    //   emit(state.copyWith(status: SalahStatus.failure));
    // }
  }

  Future<void> refreshSalah() async {
    if (!state.status.isSuccess) return;
    if (state.salah == Salah.empty) return;
    try {
      //Remove the hardcoded city
      final salah = Salah.fromRepository(
        await _salahRepository.getSalah('Chicago'),
      );
      emit(
        state.copyWith(status: SalahStatus.success, salah: salah),
      );
    } on Exception {
      emit(state);
    }
  }

  @override
  SalahState fromJson(Map<String, dynamic> json) => SalahState.fromJson(json);

  @override
  Map<String, dynamic> toJson(SalahState state) => state.toJson();
}
