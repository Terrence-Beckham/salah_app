import 'package:logger/logger.dart';
import 'package:open_salah_api/open_salah_api.dart';

import 'models/salah.dart';

class SalahRepository {
  SalahRepository({OpenSalahApiClient? openSalahApiClient})
      : _openSalahApiClient = openSalahApiClient ?? OpenSalahApiClient();

  final OpenSalahApiClient _openSalahApiClient;
  final _logger = Logger();

  Future<SalahRepo> getSalah(String city) async {
    final location = await _openSalahApiClient.locationSearch(city);
    final salah = await _openSalahApiClient.getSalahByDay(
      latitude: location.latitude,
      longitude: location.longitude,
      // year: 2023,
      // month: 12);
    );
    _logger.d('Salah By Day: $salah');

    return SalahRepo(
      fajr: salah.timings.fajr,
      dhuhr: salah.timings.dhuhr,
      asr: salah.timings.asr,
      maghrib: salah.timings.maghrib,
      isha: salah.timings.isha,
    );
  }
}
