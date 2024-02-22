import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:open_salah_api/open_salah_api.dart' hide Salah;
import 'package:salah_repository/salah_repository.dart';

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
    final salah = await _openSalahApiClient.getSalahByMonth(
        // year: 2023,
        // month: 12);
        );
    final salahList = salah
        .map((e) => SalahRepo(
              readableDate: e.readableDate,
              fajr: e.fajr,
              sharooq: e.sharooq,
              dhuhr: e.dhuhr,
              asr: e.asr,
              maghrib: e.maghrib,
              isha: e.isha,
              gregorianDate: e.gregorianDate,
              gregorianWeekdayEnglish: e.gregorianWeekday,
              city: e.city,
              latitude: e.latitude,
              longitude: e.longitude,
            ))
        .toList();
    for (var element in salahList) {
      writeToDB(element);
    }
    return salahList.last;
  }

  Future<void> writeToDB(SalahRepo salah) async {
    await _isar.writeTxn(() async {
      await _isar.salahRepos.put(salah);
    });

  }
}
