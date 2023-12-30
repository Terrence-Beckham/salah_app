import 'package:open_salah_api/open_salah_api.dart';
import 'package:test/test.dart';

void main() {
  group('Prayer Time Tests', () {
    group('from Json', () {
      test('Test generation of a PrayerTime Object from Json', () {
        expect(
            PrayerTime.fromJson(<String, dynamic>{
              'Fajr': "01:00",
              'Sunrise': "02:00",
              'Dhuhr': "03:00",
              'Asr': "04:00",
              'Sunset': "05:00",
              'Maghrib': "06:00",
              'Isha': "07:00",
              'Imsak': "08:00",
              'Midnight': "09:00",
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
