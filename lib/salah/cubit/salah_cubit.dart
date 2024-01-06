import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/salah/models/salah.dart';
import 'package:salah_repository/salah_repository.dart' hide SalahRepo;

part 'salah_cubit.g.dart';
part 'salah_state.dart';

class SalahCubit extends Cubit<SalahState> {
  SalahCubit(this._salahRepository) : super(const SalahState());
  final SalahRepository _salahRepository;

  final _logger = Logger();

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return Geolocator.getCurrentPosition();
  }

  Future<void> fetchSalah(String city) async {
    // if (city == null || city.isEmpty) return;
    emit(state.copyWith(status: SalahStatus.loading));

    try {
      final salah = Salah.fromRepository(await _salahRepository.getSalah(city));
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

  // @override
  // SalahState fromJson(Map<String, dynamic> json)
// => SalahState.fromJson(json);
  //
  // @override
  // Map<String, dynamic> toJson(SalahState state) => state.toJson();
}
