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
