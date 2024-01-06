import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:salah_repository/salah_repository.dart';

part 'salah.g.dart';

@JsonSerializable()
class Salah extends Equatable {
  const Salah({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory Salah.fromRepository(SalahRepo salah) {
    return Salah(
      fajr: salah.fajr,
      dhuhr: salah.dhuhr,
      asr: salah.asr,
      maghrib: salah.maghrib,
      isha: salah.isha,
    );
  }
  factory Salah.fromJson(Map<String, dynamic> json) => _$SalahFromJson(json);

  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  @override
  List<Object?> get props => [fajr, dhuhr, asr, maghrib, isha];

  Map<String, dynamic> toJson() => _$SalahToJson(this);

  //Fallback Empty Salah object
  static const empty = Salah(
    fajr: '',
    dhuhr: '',
    asr: '',
    maghrib: '',
    isha: '',
  );
  Salah copyWith({
    String? fajr,
    String? dhuhr,
    String? asr,
    String? maghrib,
    String? isha,
  }) {
    return Salah(
      fajr: fajr ?? this.fajr,
      dhuhr: dhuhr ?? this.dhuhr,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      isha: isha ?? this.isha,
    );
  }
}
