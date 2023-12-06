// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'hijiri.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HijriDate _$HijriDateFromJson(Map<String, dynamic> json) => $checkedCreate(
      'HijriDate',
      json,
      ($checkedConvert) {
        final val = HijriDate(
          date: $checkedConvert('date', (v) => v as String),
          format: $checkedConvert('format', (v) => v as String),
          day: $checkedConvert('day', (v) => v as int),
          weekday: $checkedConvert('weekday', (v) => v as String),
          month: $checkedConvert('month', (v) => v as int),
          enMonth: $checkedConvert('en_month', (v) => v as String),
          year: $checkedConvert('year', (v) => v as int),
          designation: $checkedConvert('designation', (v) => v as String),
          holidays: $checkedConvert('holidays',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
      fieldKeyMap: const {'enMonth': 'en_month'},
    );
