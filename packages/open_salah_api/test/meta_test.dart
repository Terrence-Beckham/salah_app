import 'package:open_salah_api/open_salah_api.dart';
import 'package:test/test.dart';

void main() {
  group('Meta testing', () {
    group('from Json', () {
      test('generate a correct meta object from Json', () {
        expect(
            Meta.fromJson(<String, dynamic>{
              'latitude': 41.8504444,
              'longitude': 41.8504444,
              'timezone': 'eastern',
              'method': 'Hanafi',
              'adjustment': 'No',
              'midnight': 'Yes',
              'school': 'Hanafi',
            }),
            isA<Meta>()
                .having((x) => x.latitude, 'latitude', 41.8504444)
                .having((x) => x.longitude, 'longitude', 41.8504444)
                .having((x) => x.timezone, 'timezine', 'eastern')
                .having((x) => x.method, 'method', 'Hanafi')
                .having((x) => x.adjustment, 'latitudeAdjustmentMethod', 'No')
                .having((x) => x.midnight, 'midnightMode', 'Yes')
                .having((x) => x.school, 'school', 'Hanafi'));
      });
    });
  });
}
