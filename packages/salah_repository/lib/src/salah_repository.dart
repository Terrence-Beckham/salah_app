import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:open_salah_api/open_salah_api.dart' hide Salah;
import 'package:salah_repository/salah_repository.dart';
import 'models/salah.dart' show SalahRepo;

class SalahRepository {
  SalahRepository({OpenSalahApiClient? openSalahApiClient, required Isar isar})
      : _openSalahApiClient = openSalahApiClient ?? OpenSalahApiClient(),
        _isar = isar;
  final Isar _isar;
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
   final salahFromRepo= SalahRepo(
      readableDate: salah.readableDate,
      fajr: salah.fajr,
      dhuhr: salah.dhuhr,
      asr: salah.asr,
      maghrib: salah.maghrib,
      isha: salah.isha,
      gregorianDate: salah.gregorianDate,
      gregorianWeekdayEnglish: salah.gregorianWeekday,
      city: salah.city,
    ); // _localStorageSalahApi.addSalah( salah);
    await _isar.writeTxn(() async {
      await _isar.salahRepos.put(salahFromRepo); // insert & update
    });
    return salahFromRepo;
  }
}
