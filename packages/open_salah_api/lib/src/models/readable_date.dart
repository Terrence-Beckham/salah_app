import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


class ReadableDate extends Equatable {
  final String dateEnglish;

  const ReadableDate({required this.dateEnglish});


  @override
  // TODO: implement props
  List<Object?> get props => [dateEnglish];
factory ReadableDate.fromJson(Map<String, dynamic> json) {
  final String dateEnglish = json['readable'] as String;

  return ReadableDate(dateEnglish: dateEnglish);

}}

// "date": {
// "readable": "24 Apr 2014",
// "timestamp": "1398332113",
// "gregorian": {
// "date": "15-05-2018",
// "format": "DD-MM-YYYY",
// "day": "15",
// "weekday": {
// "en": "Tuesday"
// },
// "month": {
// "number": 5,
// "en": "May",
// },
// "year": "2018",
// "designation": {
// "abbreviated": "AD",
// "expanded": "Anno Domini",
// },
// },
