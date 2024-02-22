import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:salah_repository/salah_repository.dart';

part 'salah.g.dart';

@JsonSerializable()
class Salah extends Equatable {
  const Salah({
    required this.fajr,
    required this.sharooq,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.gregorianDate,
    required this.gregorianDay,
    required this.gregorianMonth,
    required this.gregorianMonthNumeral,
    required this.gregorianYear,
    required this.readableDate,
    required this.gregorianWeekdayEnglish,
    required this.city,
  });

  factory Salah.fromRepository(SalahRepo salah) {
    return Salah(
      fajr: salah.fajr,
      sharooq: salah.sharooq,
      dhuhr: salah.dhuhr,
      asr: salah.asr,
      maghrib: salah.maghrib,
      isha: salah.isha,
      gregorianDate: salah.gregorianDate,
      gregorianDay: salah.gregorianDay,
      gregorianMonth: salah.gregorianMonth,
      gregorianYear: salah.gregorianYear,
      gregorianMonthNumeral: salah.gregorianMonthNumeral,
      readableDate: salah.readableDate,
      gregorianWeekdayEnglish: salah.gregorianWeekdayEnglish,
      city: salah.city,
    );
  }

  factory Salah.fromJson(Map<String, dynamic> json) => _$SalahFromJson(json);

  final String fajr;
  final String sharooq;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String gregorianDate;
  final String gregorianDay;
  final String gregorianMonth;
  final int gregorianMonthNumeral;
  final String gregorianYear;
  final String readableDate;
  final String gregorianWeekdayEnglish;
  final String city;

  @override
  List<Object?> get props => [
        fajr,
        sharooq,
        dhuhr,
        asr,
        maghrib,
        isha,
        gregorianDate,
        readableDate,
        gregorianWeekdayEnglish,
        gregorianDay,
        gregorianMonth,
        gregorianMonthNumeral,
        gregorianYear,
        city,
      ];

  Map<String, dynamic> toJson() => _$SalahToJson(this);

  //Fallback Empty Salah object
  static const empty = Salah(
    fajr: '',
    sharooq: '',
    dhuhr: '',
    asr: '',
    maghrib: '',
    isha: '',
    gregorianDate: '',
    readableDate: '',
    gregorianWeekdayEnglish: '',
    city: '',
    gregorianDay: '',
    gregorianMonth: '',
    gregorianMonthNumeral: 0,
    gregorianYear: '',
  );

  Salah copyWith({
    String? fajr,
    String? sharooq,
    String? dhuhr,
    String? asr,
    String? maghrib,
    String? isha,
    String? gregorianDate,
    String? gregorianDay,
    String? gregorianMonth,
    int? gregorianMonthNumeral,
    String? gregorianYear,
    String? readableDate,
    String? gregorianWeekdayEnglish,
    String? city,
  }) {
    return Salah(
      fajr: fajr ?? this.fajr,
      sharooq: sharooq ?? this.sharooq,
      dhuhr: dhuhr ?? this.dhuhr,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      isha: isha ?? this.isha,
      gregorianDate: gregorianDate ?? this.gregorianDate,
      readableDate: readableDate ?? this.readableDate,
      gregorianWeekdayEnglish:
          gregorianWeekdayEnglish ?? this.gregorianWeekdayEnglish,
      city: city ?? this.city,
      gregorianDay: gregorianDay ?? this.gregorianDay,
      gregorianMonth: gregorianMonth ?? this.gregorianMonth,
      gregorianMonthNumeral:
          gregorianMonthNumeral ?? this.gregorianMonthNumeral,
      gregorianYear: gregorianYear ?? this.gregorianYear,
    );
  }
}
