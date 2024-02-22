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
          sharooq: $checkedConvert('sharooq', (v) => v as String),
          dhuhr: $checkedConvert('dhuhr', (v) => v as String),
          asr: $checkedConvert('asr', (v) => v as String),
          maghrib: $checkedConvert('maghrib', (v) => v as String),
          isha: $checkedConvert('isha', (v) => v as String),
          gregorianDate: $checkedConvert('gregorian_date', (v) => v as String),
          gregorianDay: $checkedConvert('gregorian_day', (v) => v as String),
          gregorianMonth:
              $checkedConvert('gregorian_month', (v) => v as String),
          gregorianMonthNumeral:
              $checkedConvert('gregorian_month_numeral', (v) => v as int),
          gregorianYear: $checkedConvert('gregorian_year', (v) => v as String),
          readableDate: $checkedConvert('readable_date', (v) => v as String),
          gregorianWeekdayEnglish:
              $checkedConvert('gregorian_weekday_english', (v) => v as String),
          city: $checkedConvert('city', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'gregorianDate': 'gregorian_date',
        'gregorianDay': 'gregorian_day',
        'gregorianMonth': 'gregorian_month',
        'gregorianMonthNumeral': 'gregorian_month_numeral',
        'gregorianYear': 'gregorian_year',
        'readableDate': 'readable_date',
        'gregorianWeekdayEnglish': 'gregorian_weekday_english'
      },
    );

Map<String, dynamic> _$SalahToJson(Salah instance) => <String, dynamic>{
      'fajr': instance.fajr,
      'sharooq': instance.sharooq,
      'dhuhr': instance.dhuhr,
      'asr': instance.asr,
      'maghrib': instance.maghrib,
      'isha': instance.isha,
      'gregorian_date': instance.gregorianDate,
      'gregorian_day': instance.gregorianDay,
      'gregorian_month': instance.gregorianMonth,
      'gregorian_month_numeral': instance.gregorianMonthNumeral,
      'gregorian_year': instance.gregorianYear,
      'readable_date': instance.readableDate,
      'gregorian_weekday_english': instance.gregorianWeekdayEnglish,
      'city': instance.city,
    };
