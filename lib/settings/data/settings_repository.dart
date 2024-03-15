import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/settings/models/settings.dart';

class SettingsRepository {
  SettingsRepository({required Isar isar}) : _isar = isar {
    init();
  }

  final Isar _isar;
  final _logger = Logger();

  Future<Settings?> init() async {
    final  settings =
        await _isar.settings.filter().nameMatches('SETTINGS').findFirst();
    _logger.i('This is the settings object $settings');
    if (settings == null) {
      await addSettingsToDb();
    }
    return settings;
  }

  Future<void> addSettingsToDb() async {
    const newSettings = Settings();
    await _isar.writeTxn(() async => _isar.settings.put(newSettings));
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
