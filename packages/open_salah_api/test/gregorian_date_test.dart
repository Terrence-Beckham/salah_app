import 'package:open_salah_api/open_salah_api.dart';
import 'package:test/test.dart';

void main() {
  group('Gregorian Date', () {
    group('From Json', () {
      test('Return correct Gregorian Date object', () {
        expect(
          GregorianDate.fromJson(<String, dynamic>{
            'date': '15-05-2018',
            'format': "DD-MM-YYYY",
            'day': 15,
            'weekday': 'Saturday',
            'month': 1,
            'english': 'January',
            'year': 2023,
            'designation': 'AD'
          }),
          isA<GregorianDate>()
              .having((x) => x.date, 'date', "15-05-2018")
              .having((x) => x.format, 'format', "DD-MM-YYYY")
              .having((x) => x.day, 'day', 15)
              .having((x) => x.weekday, 'weekday', 'Saturday')
              .having((x) => x.month, 'month', 1)
              .having((x) => x.english, 'enMonth', 'January')
              .having((x) => x.year, 'year', 2023)
              .having((x) => x.designation, 'designation', 'AD'),
        );
      });
    });
  });
}
