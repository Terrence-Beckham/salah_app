import 'package:open_salah_api/open_salah_api.dart';
import 'package:test/test.dart';

void main() {
  group('Prayer Time Tests', () {
    group('from Json', () {
      test('Test generation of a PrayerTime Object from Json', () {
        expect(
            PrayerTime.fromJson(<String, dynamic>{
              'fajr': "01:00",
              'sunrise': "02:00",
              'dhuhr': "03:00",
              'asr': "04:00",
              'sunset': "05:00",
              'maghrib': "06:00",
              'isha': "07:00",
              'imsak': "08:00",
              'midnight': "09:00",
            }),
            isA<PrayerTime>()
                .having((x) => x.fajr, 'fajr', "01:00")
                .having((x) => x.sunrise, 'sunrise', "02:00")
                .having((x) => x.dhuhr, 'dhuhr', "03:00")
                .having((x) => x.asr, 'asr', "04:00")
                .having((x) => x.sunset, 'sunset', "05:00")
                .having((x) => x.maghrib, 'maghrib', "06:00")
                .having((x) => x.isha, 'isha', "07:00")
                .having((x) => x.imsak, 'imsak', "08:00")
                .having((x) => x.midnight, 'midnight', "09:00"));
      });
    });
  });
}
