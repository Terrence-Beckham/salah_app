import 'package:open_salah_api/open_salah_api.dart';
import 'package:test/test.dart';

void main() {
  group('Location', () {
    group('from Json', () {
      test('returns correct location object', () {
        expect(
            Location.fromJson(<String, dynamic>{
              'id': 4887392,
              'name': 'Chicago',
              'latitude': 41.8504444,
              'longitude': -87.65005,
            }),
            isA<Location>()
                .having((w) => w.id, 'id', 48873932)
                .having((w) => w.name, 'name', 'Chicago')
                .having((w) => w.latitude, 'latitude', 41.8504444)
                .having((w) => w.longitude, 'longitude', -87.65005));
      });
    });
  });
}
