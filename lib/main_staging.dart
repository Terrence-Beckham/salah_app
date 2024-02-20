import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salah_app/app/app.dart';
import 'package:salah_app/bootstrap.dart';
import 'package:salah_repository/salah_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [SalahRepoSchema],
    directory: dir.path,
  );

  final salahRepository = SalahRepository(isar: isar);
  await bootstrap(
    () {
      return MyApp(
        salahRepository: salahRepository,
      );
    },
  );
}
