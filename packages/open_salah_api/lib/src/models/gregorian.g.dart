// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'gregorian.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gregorian _$GregorianFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Gregorian',
      json,
      ($checkedConvert) {
        final val = Gregorian(
          date: $checkedConvert('date', (v) => v as String),
          format: $checkedConvert('format', (v) => v as String),
          day: $checkedConvert('day', (v) => v as int),
          weekday: $checkedConvert('weekday', (v) => v as String),
          month: $checkedConvert('month', (v) => v as int),
          enMonth: $checkedConvert('en_month', (v) => v as String),
          year: $checkedConvert('year', (v) => v as int),
          designation: $checkedConvert('designation', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'enMonth': 'en_month'},
    );
