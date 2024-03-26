part of 'salah_bloc.dart';

enum SalahStatus { initial, loading, success, failure,  }

enum CurrentSalah { Fajr, Sharooq, Dhuhr, Asr, Maghrib, Isha, unknown }

enum NextSalah { Fajr, Sharooq, Dhuhr, Asr, Maghrib, Isha, unknown }

final class SalahState extends Equatable {
  const SalahState({required this.salah, required this.status});

  final Salah salah;
  final SalahStatus status;




  @override
  List<Object?> get props => [status, salah];

  SalahState copyWith({
    Salah? salah,
    SalahStatus? status,
  }) {
    return SalahState(
      salah: salah ?? this.salah,
      status: status ?? this.status,
    );
  }
}
