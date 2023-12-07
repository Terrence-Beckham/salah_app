// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'gregorian_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GregorianDate _$GregorianDateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'GregorianDate',
      json,
      ($checkedConvert) {
        final val = GregorianDate(
          date: $checkedConvert('date', (v) => v as String),
          format: $checkedConvert('format', (v) => v as String),
          day: $checkedConvert('day', (v) => v as int),
          weekday: $checkedConvert('weekday', (v) => v as String),
          month: $checkedConvert('month', (v) => v as int),
          english: $checkedConvert('english', (v) => v as String),
          year: $checkedConvert('year', (v) => v as int),
          designation: $checkedConvert('designation', (v) => v as String),
        );
        return val;
      },
    );
