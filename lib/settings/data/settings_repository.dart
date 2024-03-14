import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:salah_app/settings/models/settings.dart';

class SettingsRepository {
  SettingsRepository({required Isar isar}) : _isar = isar {
    _init();
  }



  final Isar _isar;
  final _logger = Logger();

  // Future<Settings> _init() async {
  //     var settings =  await _isar.settings.filter().nameMatches(
  //         'SETTINGS',).findFirst();
  //     _logger.i('This is the settings object ${settings!}');
  //     if (settings == null)
  //     return settings ??= const Settings();
  //
  // }

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
