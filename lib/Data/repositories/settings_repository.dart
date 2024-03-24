import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/salah/view/salah_view.dart';
import 'package:salah_app/settings/models/settings.dart';

class SettingsRepository {
  SettingsRepository({required Isar isar}) : _isar = isar {
    init();
  }

  final Isar _isar;
  final _logger = Logger();

  Future<Settings?> init() async {
    final settings =
        await _isar.settings.filter().nameMatches('SETTINGS').findFirst();
    _logger.i('This is the settings object $settings');
    if (settings == null) {
      await initSettingsDB();
    }
    return settings;
  }

  Future<void> updateIncrementOffset(PrayerName prayerName) async {
    final settings =
        await _isar.settings.filter().nameMatches('SETTINGS').findFirst();
    switch (prayerName) {
      case PrayerName.fajr:
        final fajrOffset = settings?.fajrOffset;
        final newOffset = fajrOffset! + 1;
        final newSettings = settings?.copyWith(fajrOffset: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.sharooq:
        final sharooqOffset = settings?.sharooqOffset;
        final newOffset = sharooqOffset! + 1;
        final newSettings = settings?.copyWith(sharooqOffset: newOffset);
        await updateSettingsToDB(newSettings!);

      case PrayerName.dhuhr:
        final dhuhrOffset = settings?.dhuhrOffset;
        final newOffset = dhuhrOffset! + 1;
        final newSettings = settings?.copyWith(dhuhrOffset: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.asr:
        final asrOffset = settings?.asrOffset;
        final newOffset = asrOffset! + 1;
        final newSettings = settings?.copyWith(asrOffset: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.maghrib:
        final maghribOffset = settings?.maghribOffset;
        final newOffset = maghribOffset! + 1;
        final newSettings = settings?.copyWith(maghribOffset: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.isha:
        final ishaOffset = settings?.ishaOffset;
        final newOffset = ishaOffset! + 1;
        final newSettings = settings?.copyWith(ishaOffset: newOffset);
        await updateSettingsToDB(newSettings!);
    }
  }

  Future<void> updateDecrementOffset(PrayerName prayerName) async {
    final settings =
        await _isar.settings.filter().nameMatches('SETTINGS').findFirst();
    switch (prayerName) {
      case PrayerName.fajr:
        final fajrOffset = settings?.fajrOffset;
        final newOffset = fajrOffset! - 1;
        final newSettings = settings?.copyWith(fajrOffset: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.sharooq:
        final sharooqOffset = settings?.sharooqOffset;
        final newOffset = sharooqOffset! - 1;
        final newSettings = settings?.copyWith(sharooqOffset: newOffset);
        await updateSettingsToDB(newSettings!);

      case PrayerName.dhuhr:
        final dhuhrOffset = settings?.dhuhrOffset;
        final newOffset = dhuhrOffset! - 1;
        final newSettings = settings?.copyWith(dhuhrOffset: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.asr:
        final asrOffset = settings?.asrOffset;
        final newOffset = asrOffset! - 1;
        final newSettings = settings?.copyWith(asrOffset: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.maghrib:
        final maghribOffset = settings?.maghribOffset;
        final newOffset = maghribOffset! - 1;
        final newSettings = settings?.copyWith(maghribOffset: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.isha:
        final ishaOffset = settings?.ishaOffset;
        final newOffset = ishaOffset! - 1;
        final newSettings = settings?.copyWith(ishaOffset: newOffset);
        await updateSettingsToDB(newSettings!);
    }
  }

  Future<void> initSettingsDB() async {
    const newSettings = Settings();
    await _isar.writeTxn(() async => _isar.settings.put(newSettings));
  }

  Future<void> updateSettingsToDB(Settings settings) async {
    await _isar.writeTxn(() async => _isar.settings.put(settings));
  }
}

//Future<void> writeToDB(SalahRepo salah) async {
//     await _isar.writeTxn(() async {
//       await _isar.salahRepos.put(salah);
//     });
//   }
//
//   Future<SalahRepo?> retrieveSalah() async {
//     final time = DateTime.now();
//     // final formatedTime = DateFormat.yMMMd().format(DateTime.now());
//     final formatedTime = DateFormat('dd-MM-yyyy').format(DateTime.now());
//     final SalahRepo? salah = await _isar.salahRepos
//         .filter()
//         .gregorianDateMatches(formatedTime)
//         .findFirst();
//     _logger.i('this is the salah from the db for today $salah');
//     return salah;
//   }
