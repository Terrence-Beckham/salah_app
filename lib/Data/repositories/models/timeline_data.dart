import 'package:equatable/equatable.dart';
import 'package:salah_app/salah/salah_bloc.dart';

class TimelineData extends Equatable {
  const TimelineData({
    required this.fajrTime,
    required this.fajrOffsetTime,
    required this.sharooqTime,
    required this.sharooqOffsetTime,
    required this.dhuhrTime,
    required this.dhuhrOffsetTime,
    required this.asrTime,
    required this.asrOffsetTime,
    required this.maghribTime,
    required this.maghribOffsetTime,
    required this.ishaTime,
    required this.ishaOffsetTime,
    required this.timeToNextSalah,
    required this.currentSalah,
    required this.nextSalah,
    required this.hoursLeft,
    required this.minutesLeft,
    this.isAthanTime = false,
  });

  final int timeToNextSalah;
  final CurrentSalah currentSalah;
  final NextSalah nextSalah;
  final int hoursLeft;
  final bool isAthanTime;
  final int minutesLeft;
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

  @override
  List<Object> get props => [
        timeToNextSalah,
        currentSalah,
        nextSalah,
        hoursLeft,
        isAthanTime,
        minutesLeft,
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
      ];

  static const empty = TimelineData(
    timeToNextSalah: 0,
    nextSalah: NextSalah.unknown,
    currentSalah: CurrentSalah.unknown,
    hoursLeft: 0,
    minutesLeft: 0,
    fajrTime: '',
    fajrOffsetTime: '',
    sharooqTime: '',
    sharooqOffsetTime: '',
    dhuhrTime: '',
    dhuhrOffsetTime: '',
    asrTime: '',
    asrOffsetTime: '',
    maghribTime: '',
    maghribOffsetTime: '',
    ishaTime: '',
    ishaOffsetTime: '',
  );

  TimelineData copyWith({
    int? timeToNextSalah,
    CurrentSalah? currentSalah,
    NextSalah? nextSalah,
    int? hoursLeft,
    bool? isAthanTime,
    int? minutesLeft,
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
  }) {
    return TimelineData(
      timeToNextSalah: timeToNextSalah ?? this.timeToNextSalah,
      currentSalah: currentSalah ?? this.currentSalah,
      nextSalah: nextSalah ?? this.nextSalah,
      hoursLeft: hoursLeft ?? this.hoursLeft,
      isAthanTime: isAthanTime ?? this.isAthanTime,
      minutesLeft: minutesLeft ?? this.minutesLeft,
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
    );
  }
}
