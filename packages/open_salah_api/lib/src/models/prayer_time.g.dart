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
          Fajr: $checkedConvert('fajr', (v) => v as String),
          Sunrise: $checkedConvert('sunrise', (v) => v as String),
          Dhuhr: $checkedConvert('dhuhr', (v) => v as String),
          Asr: $checkedConvert('asr', (v) => v as String),
          Sunset: $checkedConvert('sunset', (v) => v as String),
          Maghrib: $checkedConvert('maghrib', (v) => v as String),
          Isha: $checkedConvert('isha', (v) => v as String),
          Imsak: $checkedConvert('imsak', (v) => v as String),
          Midnight: $checkedConvert('midnight', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'Fajr': 'fajr',
        'Sunrise': 'sunrise',
        'Dhuhr': 'dhuhr',
        'Asr': 'asr',
        'Sunset': 'sunset',
        'Maghrib': 'maghrib',
        'Isha': 'isha',
        'Imsak': 'imsak',
        'Midnight': 'midnight'
      },
    );
