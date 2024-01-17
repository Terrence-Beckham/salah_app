import 'package:salah_app/app/app.dart';
import 'package:salah_app/bootstrap.dart';
import 'package:salah_repository/salah_repository.dart';

void main() {
  bootstrap(
    () => MyApp(
      salahRepository: SalahRepository(),
    ),
  );
}
