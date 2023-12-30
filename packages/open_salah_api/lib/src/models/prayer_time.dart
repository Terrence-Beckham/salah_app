class PrayerTime {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;

  factory PrayerTime.fromJson(Map<String, dynamic> json) {
    final String fajr = json['Fajr'] as String;
    final String sunrise = json['Sunrise'] as String;
    final String dhuhr = json['Dhuhr'] as String;
    final String asr = json['Asr'] as String;
    final String sunset = json['Sunset'] as String;
    final String maghrib = json['Maghrib'] as String;
    final String isha = json['Isha'] as String;
    final String imsak = json['Imsak'] as String;
    final String midnight = json['Midnight'] as String;
    return PrayerTime(
        fajr: fajr,
        sunrise: sunrise,
        dhuhr: dhuhr,
        asr: asr,
        sunset: sunset,
        maghrib: maghrib,
        isha: isha,
        imsak: imsak,
        midnight: midnight);
  }

  PrayerTime(
      {required this.fajr,
      required this.sunrise,
      required this.dhuhr,
      required this.asr,
      required this.sunset,
      required this.maghrib,
      required this.isha,
      required this.imsak,
      required this.midnight});
}
