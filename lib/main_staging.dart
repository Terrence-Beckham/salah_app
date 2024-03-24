import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salah_app/Data/repositories/timer_repository.dart';
import 'package:salah_app/app/app.dart';
import 'package:salah_app/bootstrap.dart';
import 'package:salah_app/Data/repositories/settings_repository.dart';
import 'package:salah_app/settings/models/settings.dart';
import 'package:salah_repository/salah_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isarDB = await Isar.open(
    [SalahRepoSchema, SettingsSchema],
    directory: dir.path,
  );

  final salahRepository = SalahRepository(isar: isarDB);
  final settingsRepository = SettingsRepository(isar: isarDB);
  final timerRepository =
      TimerRepository(isarDb: isarDB, settingsRepository: settingsRepository);
  await bootstrap(
    () {
      return MyApp(
        salahRepository: salahRepository,
        timerRepository: timerRepository,
        settingsRepository: settingsRepository,
      );
    },
  );
}
