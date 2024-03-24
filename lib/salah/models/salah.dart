import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:salah_app/salah/salah_bloc.dart';
import 'package:salah_repository/salah_repository.dart';
@immutable
class Salah extends Equatable {
  const Salah({
    required this.hoursLeft,
    required this.minutesLeft,
    required this.isAthanTime,
    required this.timeToNextSalah,
    required this.nextSalah,
    required this.currentSalah,
    required this.fajrOffsetTime,
    required this.sharooqOffsetTime,
    required this.dhuhrOffsetTime,
    required this.asrOffsetTime,
    required this.maghribOffsetTime,
    required this.ishaOffsetTime,
    required this.fajrTime,
    required this.sharooqTime,
    required this.dhuhrTime,
    required this.asrTime,
    required this.maghribTime,
    required this.ishaTime,
    required this.gregorianDate,
    required this.gregorianDay,
    required this.gregorianMonth,
    required this.gregorianMonthNumeral,
    required this.gregorianYear,
    required this.readableDate,
    required this.gregorianWeekdayEnglish,
    required this.hijriDate,
    required this.hijriDay,
    required this.hijriWeekdayEnglish,
    required this.hijriWeekdayArabic,
    required this.hijriMonthEnglish,
    required this.hijriMonthArabic,
    required this.hijriYear,
    required this.city,
  });

  factory Salah.fromRepository(SalahRepo salah) {
    return Salah(
      fajrTime: salah.fajr,
      sharooqTime: salah.sharooq,
      dhuhrTime: salah.dhuhr,
      asrTime: salah.asr,
      maghribTime: salah.maghrib,
      ishaTime: salah.isha,
      gregorianDate: salah.gregorianDate,
      gregorianDay: salah.gregorianDay,
      gregorianMonth: salah.gregorianMonth,
      gregorianYear: salah.gregorianYear,
      gregorianMonthNumeral: salah.gregorianMonthNumeral,
      readableDate: salah.readableDate,
      gregorianWeekdayEnglish: salah.gregorianWeekdayEnglish,
      city: salah.city,
      hijriDate: salah.hijriDate,
      hijriDay: salah.hijriDay,
      hijriWeekdayEnglish: salah.hijriWeekdayEnglish,
      hijriWeekdayArabic: salah.hijriWeekdayArabic,
      hijriMonthEnglish: salah.hijriMonthEnglish,
      hijriMonthArabic: salah.hijriMonthArabic,
      hijriYear: salah.hijriYear,
      fajrOffsetTime: '',
      sharooqOffsetTime: '',
      dhuhrOffsetTime: '',
      asrOffsetTime: '',
      maghribOffsetTime: '',
      ishaOffsetTime: '',
      currentSalah: CurrentSalah.unknown,
      nextSalah: NextSalah.unknown,
      timeToNextSalah: 0,
      isAthanTime: false,
      hoursLeft: 0,
      minutesLeft: 0,
    );
  }



  final bool isAthanTime;
  final int timeToNextSalah;
  final CurrentSalah currentSalah;
  final NextSalah nextSalah;
  final String fajrTime;
  final String fajrOffsetTime;
  final String sharooqTime;
  final String sharooqOffsetTime;
  final String dhuhrTime;
  final String dhuhrOffsetTime;
  final String asrTime;
  final String asrOffsetTime;
  final String maghribTime;
  final String maghribOffsetTime;
  final String ishaTime;
  final String ishaOffsetTime;
  final String gregorianDate;
  final String gregorianDay;
  final String gregorianMonth;
  final int gregorianMonthNumeral;
  final int hoursLeft;
  final int minutesLeft;

  final String gregorianYear;
  final String hijriDate;
  final String hijriDay;
  final String hijriWeekdayEnglish;
  final String hijriWeekdayArabic;
  final String hijriMonthEnglish;
  final String hijriMonthArabic;
  final String hijriYear;
  final String readableDate;
  final String gregorianWeekdayEnglish;
  final String city;

  //Fallback Empty Salah object
  static const empty = Salah(
    fajrTime: '',
    sharooqTime: '',
    dhuhrTime: '',
    asrTime: '',
    maghribTime: '',
    ishaTime: '',
    gregorianDate: '',
    readableDate: '',
    gregorianWeekdayEnglish: '',
    city: '',
    gregorianDay: '',
    gregorianMonth: '',
    gregorianMonthNumeral: 0,
    gregorianYear: '',
    hijriDate: '',
    hijriDay: '',
    hijriWeekdayEnglish: '',
    hijriWeekdayArabic: '',
    hijriMonthEnglish: '',
    hijriMonthArabic: '',
    hijriYear: '',
    fajrOffsetTime: '',
    sharooqOffsetTime: '',
    dhuhrOffsetTime: '',
    asrOffsetTime: '',
    maghribOffsetTime: '',
    ishaOffsetTime: '',
    nextSalah: NextSalah.unknown,
    currentSalah: CurrentSalah.unknown,
    timeToNextSalah: 0,
    isAthanTime: false,
    hoursLeft: 0,
    minutesLeft: 0,
  );

  @override
  String toString() {
    return 'Salah{isAthanTime: $isAthanTime,\n timeToNextSalah: $timeToNextSalah,\n currentSalah: $currentSalah,\n nextSalah: $nextSalah,\n fajrTime: $fajrTime,\n fajrOffsetTime: $fajrOffsetTime,\n sharooqTime: $sharooqTime,\n sharooqOffsetTime: $sharooqOffsetTime,\n dhuhrTime: $dhuhrTime,\n dhuhrOffsetTime: $dhuhrOffsetTime,\n asrTime: $asrTime,\n asrOffsetTime: $asrOffsetTime,\n maghribTime: $maghribTime,\n maghribOffsetTime: $maghribOffsetTime,\n ishaTime: $ishaTime,\n'
        ' ishaOffsetTime: $ishaOffsetTime,\n gregorianDate: $gregorianDate,\n gregorianDay: $gregorianDay,\n gregorianMonth: $gregorianMonth,\n gregorianMonthNumeral: $gregorianMonthNumeral,\n hoursLeft: $hoursLeft,\n minutesLeft: $minutesLeft,\n gregorianYear: $gregorianYear,\n hijriDate: $hijriDate,\n hijriDay: $hijriDay,\n hijriWeekdayEnglish: $hijriWeekdayEnglish,\n hijriWeekdayArabic: $hijriWeekdayArabic,\n hijriMonthEnglish: $hijriMonthEnglish,\n hijriMonthArabic: $hijriMonthArabic,\n hijriYear: $hijriYear,\n readableDate: $readableDate,\n gregorianWeekdayEnglish: $gregorianWeekdayEnglish,'
        '\n city: $city}';
  }

  @override
  List<Object> get props => [
        isAthanTime,
        hoursLeft,
        minutesLeft,
        timeToNextSalah,
        currentSalah,
        nextSalah,
        fajrTime,
        fajrOffsetTime,
        sharooqTime,
        sharooqOffsetTime,
        dhuhrTime,
        dhuhrOffsetTime,
        asrTime,
        asrOffsetTime,
        maghribTime,
        maghribOffsetTime,
        ishaTime,
        ishaOffsetTime,
        gregorianDate,
        gregorianDay,
        gregorianMonth,
        gregorianMonthNumeral,
        gregorianYear,
        hijriDate,
        hijriDay,
        hijriWeekdayEnglish,
        hijriWeekdayArabic,
        hijriMonthEnglish,
        hijriMonthArabic,
        hijriYear,
        readableDate,
        gregorianWeekdayEnglish,
        city,
      ];

  Salah copyWith({
    bool? isAthanTime,
    int? timeToNextSalah,
    CurrentSalah? currentSalah,
    NextSalah? nextSalah,
    String? fajrTime,
    String? fajrOffsetTime,
    String? sharooqTime,
    String? sharooqOffsetTime,
    String? dhuhrTime,
    String? dhuhrOffsetTime,
    String? asrTime,
    String? asrOffsetTime,
    String? maghribTime,
    String? maghribOffsetTime,
    String? ishaTime,
    String? ishaOffsetTime,
    String? gregorianDate,
    String? gregorianDay,
    String? gregorianMonth,
    int? gregorianMonthNumeral,
    int? hoursLeft,
    int? minutesLeft,
    String? gregorianYear,
    String? hijriDate,
    String? hijriDay,
    String? hijriWeekdayEnglish,
    String? hijriWeekdayArabic,
    String? hijriMonthEnglish,
    String? hijriMonthArabic,
    String? hijriYear,
    String? readableDate,
    String? gregorianWeekdayEnglish,
    String? city,
  }) {
    return Salah(
      isAthanTime: isAthanTime ?? this.isAthanTime,
      timeToNextSalah: timeToNextSalah ?? this.timeToNextSalah,
      currentSalah: currentSalah ?? this.currentSalah,
      nextSalah: nextSalah ?? this.nextSalah,
      fajrTime: fajrTime ?? this.fajrTime,
      fajrOffsetTime: fajrOffsetTime ?? this.fajrOffsetTime,
      sharooqTime: sharooqTime ?? this.sharooqTime,
      sharooqOffsetTime: sharooqOffsetTime ?? this.sharooqOffsetTime,
      dhuhrTime: dhuhrTime ?? this.dhuhrTime,
      dhuhrOffsetTime: dhuhrOffsetTime ?? this.dhuhrOffsetTime,
      asrTime: asrTime ?? this.asrTime,
      asrOffsetTime: asrOffsetTime ?? this.asrOffsetTime,
      maghribTime: maghribTime ?? this.maghribTime,
      maghribOffsetTime: maghribOffsetTime ?? this.maghribOffsetTime,
      ishaTime: ishaTime ?? this.ishaTime,
      ishaOffsetTime: ishaOffsetTime ?? this.ishaOffsetTime,
      gregorianDate: gregorianDate ?? this.gregorianDate,
      gregorianDay: gregorianDay ?? this.gregorianDay,
      gregorianMonth: gregorianMonth ?? this.gregorianMonth,
      gregorianMonthNumeral:
          gregorianMonthNumeral ?? this.gregorianMonthNumeral,
      hoursLeft: hoursLeft ?? this.hoursLeft,
      minutesLeft: minutesLeft ?? this.minutesLeft,
      gregorianYear: gregorianYear ?? this.gregorianYear,
      hijriDate: hijriDate ?? this.hijriDate,
      hijriDay: hijriDay ?? this.hijriDay,
      hijriWeekdayEnglish: hijriWeekdayEnglish ?? this.hijriWeekdayEnglish,
      hijriWeekdayArabic: hijriWeekdayArabic ?? this.hijriWeekdayArabic,
      hijriMonthEnglish: hijriMonthEnglish ?? this.hijriMonthEnglish,
      hijriMonthArabic: hijriMonthArabic ?? this.hijriMonthArabic,
      hijriYear: hijriYear ?? this.hijriYear,
      readableDate: readableDate ?? this.readableDate,
      gregorianWeekdayEnglish:
          gregorianWeekdayEnglish ?? this.gregorianWeekdayEnglish,
      city: city ?? this.city,
    );
  }
}
