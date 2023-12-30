import 'package:open_salah_api/open_salah_api.dart';
import 'package:test/test.dart';

void main() {
  group('Hijri Date', () {
    group('from Json', () {
      test('Generate a correct Hijri object', () {
        expect(
            HijriDate.fromJson(<String, dynamic>{
              'date': '15-05-2023',
              'format': 'DD-MM-YYYY',
              'day': 15,
              'weekday': 'Friday',
              'month': 1,
              'year': 2023,
            }),
            isA<HijriDate>()
                .having((x) => x.date, 'date', "15-05-2023")
                .having((x) => x.format, 'format', "DD-MM-YYYY")
                .having((x) => x.day, 'day', 15)
                .having((x) => x.weekday, 'weekday', 'Friday')
                .having((x) => x.monthNumerical, 'month', 1)
                .having((x) => x.year, 'year', 2023));
      });
    });
  });
}
