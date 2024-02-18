// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salah.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Salah _$SalahFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Salah',
      json,
      ($checkedConvert) {
        final val = Salah(
          fajr: $checkedConvert('fajr', (v) => v as String),
          dhuhr: $checkedConvert('dhuhr', (v) => v as String),
          asr: $checkedConvert('asr', (v) => v as String),
          maghrib: $checkedConvert('maghrib', (v) => v as String),
          isha: $checkedConvert('isha', (v) => v as String),
          gregorianDate: $checkedConvert('gregorian_date', (v) => v as String),
          readableDate: $checkedConvert('readable_date', (v) => v as String),
          gregorianWeekdayEnglish:
              $checkedConvert('gregorian_weekday_english', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'gregorianDate': 'gregorian_date',
        'readableDate': 'readable_date',
        'gregorianWeekdayEnglish': 'gregorian_weekday_english'
      },
    );

Map<String, dynamic> _$SalahToJson(Salah instance) => <String, dynamic>{
      'fajr': instance.fajr,
      'dhuhr': instance.dhuhr,
      'asr': instance.asr,
      'maghrib': instance.maghrib,
      'isha': instance.isha,
      'gregorian_date': instance.gregorianDate,
      'readable_date': instance.readableDate,
      'gregorian_weekday_english': instance.gregorianWeekdayEnglish,
    };
