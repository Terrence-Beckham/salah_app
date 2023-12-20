import 'package:open_salah_api/open_salah_api.dart';
import 'package:test/test.dart';

void main() {
  group('Hijiri Date', () {
    group('from Json', () {
      test('Generate a correct Hijiri obje', () {
        expect(
          HijriDate.fromJson(<String, dynamic>{
            'date': '15-05-2023',
            'format': 'DD-MM-YYYY',
            'day': 15,
            'weekday': 'Friday',
            'month': 1,
            'shr': 'July',
            'year': 2023,
            'designation': 'AH',
          }),
          isA<HijriDate>()
              .having((x) => x.date, 'date', "15-05-2023")
              .having((x) => x.format, 'format', "DD-MM-YYYY")
              .having((x) => x.day, 'day', 15)
              .having((x) => x.weekday, 'weekday', 'Friday')
              .having((x) => x.month, 'month', 1)
              .having((x) => x.shr, 'shr', 'July')
              .having((x) => x.year, 'year', 2023)
              .having((x) => x.designation, 'designation', 'AH'),
        );
      });
    });
  });
}
