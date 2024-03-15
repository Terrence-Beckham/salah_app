import 'package:intl/intl.dart';
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
    final int now = today.day;
    _logger.i('today\'s date is: $now');

    //Try to get salah object from db
    final todaySalah = await retrieveSalah();
    if (todaySalah != null) {
      _logger.i('salah retrieved from DB');
      return todaySalah;
    }

    final salah = await _openSalahApiClient.getSalahByMonth();

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
              gregorianDay: e.gregorianDay,
              gregorianMonth: e.gregorianMonth,
              gregorianMonthNumeral: e.gregorianMonthNumeral,
              gregorianYear: e.gregorianYear,
              hijriDate: e.hijriDate,
              hijriWeekdayEnglish: e.hijriWeekdayEnglish,
              hijriWeekdayArabic: e.hijriWeekdayArabic,
              hijriMonthEnglish: e.hijriMonthEnglish,
              hijriMonthArabic: e.hijriMonthArabic,
              hijriYear: e.hijriYear,
              hijriDay: e.hijriDay,
            ))
        .toList();

    for (var element in salahList) {
      // _logger.i('this is the day before being entered into the db: ${element.gregorianDay}');
      writeToDB(element);
    }
//After inserting into db attempt to get today's salah from db
    final cacheSalah = await retrieveSalah();
    return cacheSalah ?? salahList.first;
  }

  Future<void> writeToDB(SalahRepo salah) async {
    await _isar.writeTxn(() async {
      await _isar.salahRepos.put(salah);
    });
  }

  Future<SalahRepo?> retrieveSalah() async {
    // final formatedTime = DateFormat.yMMMd().format(DateTime.now());
    final formattedTime = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final SalahRepo? salah = await _isar.salahRepos
        .filter()
        .gregorianDateMatches(formattedTime)
        .findFirst();
    _logger.i('this is the salah from the db for today $salah');
    return salah;
  }
}
