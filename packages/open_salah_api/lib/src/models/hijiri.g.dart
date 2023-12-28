// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hijiri.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HijriDate _$HijriDateFromJson(Map<String, dynamic> json) => HijriDate(
      date: json['date'] as String,
      format: json['format'] as String,
      day: json['day'] as int,
      weekday: json['weekday'] as String,
      month: json['month'] as int,
      shr: json['shr'] as String,
      year: json['year'] as int,
      designation: json['designation'] as String,
    );

Map<String, dynamic> _$HijriDateToJson(HijriDate instance) => <String, dynamic>{
      'date': instance.date,
      'format': instance.format,
      'day': instance.day,
      'weekday': instance.weekday,
      'month': instance.month,
      'shr': instance.shr,
      'year': instance.year,
      'designation': instance.designation,
    };
