import 'package:logger/logger.dart';
import 'package:open_salah_api/open_salah_api.dart' hide Salah;

import 'models/salah.dart' show SalahRepo;

class SalahRepository {
  SalahRepository({OpenSalahApiClient? openSalahApiClient})
      : _openSalahApiClient = openSalahApiClient ?? OpenSalahApiClient();

  final OpenSalahApiClient _openSalahApiClient;
  final _logger = Logger();

  Future<SalahRepo> getSalah() async {
    // final location = await _openSalahApiClient.locationSearch(city);
    final DateTime today = DateTime.now();
    final int month = today.month;
    final int year = today.year;
    final salah = await _openSalahApiClient.getSalahByMonth(
      // year: 2023,
      // month: 12);
    );


   ///Extract the specific elements that are needed from the original Salah object.
    return SalahRepo(
      readableDate: salah.readableDate.dateEnglish,
      fajr: salah.timings.fajr,
      dhuhr: salah.timings.dhuhr,
      asr: salah.timings.asr,
      maghrib: salah.timings.maghrib,
      isha: salah.timings.isha,
      gregorianDate: salah.gregorian.monthEnglish,
      gregorianWeekdayEnglish: salah.gregorian.weekday


    );
  }
}
