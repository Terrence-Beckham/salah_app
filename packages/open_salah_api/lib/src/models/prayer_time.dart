class PrayerTime {
  final String Fajr;
  final String Sunrise;
  final String Dhuhr;
  final String Asr;
  final String Sunset;
  final String Maghrib;
  final String Isha;
  final String Imsak;
  final String Midnight;

  factory PrayerTime.fromJson(Map<String, dynamic> json) {
    final String Fajr = json['Fajr'] as String;
    final String Sunrise = json['Sunrise'] as String;
    final String Dhuhr = json['Dhuhr'] as String;
    final String Asr = json['Asr'] as String;
    final String Sunset = json['Sunset'] as String;
    final String Maghrib = json['Maghrib'] as String;
    final String Isha = json['Isha'] as String;
    final String Imsak = json['Imsak'] as String;
    final String Midnight = json['Midnight'] as String;
    return PrayerTime(
        Fajr: Fajr,
        Sunrise: Sunrise,
        Dhuhr: Dhuhr,
        Asr: Asr,
        Sunset: Sunset,
        Maghrib: Maghrib,
        Isha: Isha,
        Imsak: Imsak,
        Midnight: Midnight);
  }

  PrayerTime(
      {required this.Fajr,
      required this.Sunrise,
      required this.Dhuhr,
      required this.Asr,
      required this.Sunset,
      required this.Maghrib,
      required this.Isha,
      required this.Imsak,
      required this.Midnight});
}
