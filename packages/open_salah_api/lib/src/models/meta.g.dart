// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Meta',
      json,
      ($checkedConvert) {
        final val = Meta(
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
          timezone: $checkedConvert('timezone', (v) => v as String),
          method: $checkedConvert('method', (v) => v as String),
          latitudeAdjustmentMethod:
              $checkedConvert('latitude_adjustment_method', (v) => v as String),
          midnightMode: $checkedConvert('midnight_mode', (v) => v as String),
          school: $checkedConvert('school', (v) => v as String),
          offset:
              $checkedConvert('offset', (v) => Map<String, int>.from(v as Map)),
        );
        return val;
      },
      fieldKeyMap: const {
        'latitudeAdjustmentMethod': 'latitude_adjustment_method',
        'midnightMode': 'midnight_mode'
      },
    );
