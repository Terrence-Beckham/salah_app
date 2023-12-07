import 'package:test/test.dart';
import 'package:open_salah_api/open_salah_api.dart';

void main() {
  group('Weather', () {
    group('From Json', () {
      test('Returns correct Weather Object', () {
        expect(
            Weather.fromJson(
                <String, dynamic>{'temperature': 15.3, 'weathercode': 63}),
            isA<Weather>()
                .having((w) => w.temperature, 'temperature', 15.3)
                .having((w) => w.weatherCode, 'weatherCode', 63));
      });
    });
  });
}
