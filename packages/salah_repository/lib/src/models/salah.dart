import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'salah.g.dart';

@JsonSerializable()
class Salah extends Equatable {
  Salah(
      {required this.fajr,
      required this.dhuhr,
      required this.asr,
      required this.maghrib,
      required this.isha});

  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  @override
  // TODO: implement props
  List<Object?> get props => [fajr, dhuhr, asr, maghrib, isha];
}
