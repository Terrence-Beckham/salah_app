import 'package:flutter/cupertino.dart';
import 'package:salah_app/app/app.dart';
import 'package:salah_repository/salah_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(salahRepository: SalahRepository()));

  // bootstrap(
  //   () => App(
  //     salahRepository: SalahRepository(),
  //   ),
  // );
}
