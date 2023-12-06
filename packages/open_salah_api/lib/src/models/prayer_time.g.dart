// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'prayer_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrayerTime _$PrayerTimeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'PrayerTime',
      json,
      ($checkedConvert) {
        final val = PrayerTime(
          fajr: $checkedConvert('fajr', (v) => v as String),
          sunrise: $checkedConvert('sunrise', (v) => v as String),
          dhuhr: $checkedConvert('dhuhr', (v) => v as String),
          asr: $checkedConvert('asr', (v) => v as String),
          sunset: $checkedConvert('sunset', (v) => v as String),
          maghrib: $checkedConvert('maghrib', (v) => v as String),
          isha: $checkedConvert('isha', (v) => v as String),
          imsak: $checkedConvert('imsak', (v) => v as String),
          midnight: $checkedConvert('midnight', (v) => v as String),
        );
        return val;
      },
    );
