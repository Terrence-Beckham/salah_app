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
                .having((x) => x.Fajr, 'fajr', "01:00")
                .having((x) => x.Sunrise, 'sunrise', "02:00")
                .having((x) => x.Dhuhr, 'dhuhr', "03:00")
                .having((x) => x.Asr, 'asr', "04:00")
                .having((x) => x.Sunset, 'sunset', "05:00")
                .having((x) => x.Maghrib, 'maghrib', "06:00")
                .having((x) => x.Isha, 'isha', "07:00")
                .having((x) => x.Imsak, 'imsak', "08:00")
                .having((x) => x.Midnight, 'midnight', "09:00"));
      });
    });
  });
}
