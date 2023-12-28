import 'package:open_salah_api/open_salah_api.dart';

import 'models/salah.dart';

class SalahRepository {
  SalahRepository({OpenSalahApiClient? openSalahApiClient})
      : _openSalahApiClient = openSalahApiClient ?? OpenSalahApiClient();

  final OpenSalahApiClient _openSalahApiClient;

  Future<Salah> getSalah(String city) async {
    final location = await _openSalahApiClient.locationSearch(city);
    final salah = await _openSalahApiClient.getSalahByDay(
        latitude: location.latitude, longitude: location.longitude);
    // year: 2023,
    // month: 12);
    return Salah(
        fajr: salah.timings.Fajr,
        dhuhr: salah.timings.Dhuhr,
        asr: salah.timings.Asr,
        maghrib: salah.timings.Maghrib,
        isha: salah.timings.Isha);
  }
}
