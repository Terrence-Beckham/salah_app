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
        final fajrOffset = settings?.fajrOffsetDisplay;
        final newOffset = fajrOffset! + 1;
        final newSettings = settings?.copyWith(fajrOffsetDisplay: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.sharooq:
        final sharooqOffset = settings?.sharooqOffsetDisplay;
        final newOffset = sharooqOffset! + 1;
        final newSettings = settings?.copyWith(sharooqOffsetDisplay: newOffset);
        await updateSettingsToDB(newSettings!);

      case PrayerName.dhuhr:
        final dhuhrOffset = settings?.dhuhrOffsetDisplay;
        final newOffset = dhuhrOffset! + 1;
        final newSettings = settings?.copyWith(dhuhrOffsetDisplay: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.asr:
        final asrOffset = settings?.asrOffsetDisplay;
        final newOffset = asrOffset! + 1;
        final newSettings = settings?.copyWith(asrOffsetDisplay: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.maghrib:
        final maghribOffset = settings?.maghribOffsetDisplay;
        final newOffset = maghribOffset! + 1;
        final newSettings = settings?.copyWith(maghribOffsetDisplay: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.isha:
        final ishaOffset = settings?.ishaOffsetDisplay;
        final newOffset = ishaOffset! + 1;
        final newSettings = settings?.copyWith(ishaOffsetDisplay: newOffset);
        await updateSettingsToDB(newSettings!);
    }
  }

  Future<void> updateDecrementOffset(PrayerName prayerName) async {
    final settings =
        await _isar.settings.filter().nameMatches('SETTINGS').findFirst();
    switch (prayerName) {
      case PrayerName.fajr:
        final fajrOffset = settings?.fajrOffsetDisplay;
        final newOffset = fajrOffset! - 1;
        final newSettings = settings?.copyWith(fajrOffsetDisplay: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.sharooq:
        final sharooqOffset = settings?.sharooqOffsetDisplay;
        final newOffset = sharooqOffset! - 1;
        final newSettings = settings?.copyWith(sharooqOffsetDisplay: newOffset);
        await updateSettingsToDB(newSettings!);

      case PrayerName.dhuhr:
        final dhuhrOffset = settings?.dhuhrOffsetDisplay;
        final newOffset = dhuhrOffset! - 1;
        final newSettings = settings?.copyWith(dhuhrOffsetDisplay: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.asr:
        final asrOffset = settings?.asrOffsetDisplay;
        final newOffset = asrOffset! - 1;
        final newSettings = settings?.copyWith(asrOffsetDisplay: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.maghrib:
        final maghribOffset = settings?.maghribOffsetDisplay;
        final newOffset = maghribOffset! - 1;
        final newSettings = settings?.copyWith(maghribOffsetDisplay: newOffset);
        await updateSettingsToDB(newSettings!);
      case PrayerName.isha:
        final ishaOffset = settings?.ishaOffsetDisplay;
        final newOffset = ishaOffset! - 1;
        final newSettings = settings?.copyWith(ishaOffsetDisplay: newOffset);
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


