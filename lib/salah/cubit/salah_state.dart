part of 'salah_cubit.dart';

enum SalahStatus { initial, loading, success, failure }

enum CurrentSalah { fajr, sharooq, dhuhr, asr, maghrib, isha, unknown }

enum NextSalah { fajr, sharooq, dhuhr, asr, maghrib, isha, unknown }

extension SalahStatusX on SalahStatus {
  bool get isInitial => this == SalahStatus.initial;

  bool get isLoading => this == SalahStatus.loading;

  bool get isSuccess => this == SalahStatus.success;

  bool get isFailure => this == SalahStatus.failure;
}

@JsonSerializable()
final class SalahState extends Equatable {
  const SalahState({
    this.status = SalahStatus.initial,
    Salah? salah,
    this.currentSalah = CurrentSalah.fajr,
    this.nextSalah = NextSalah.sharooq,
  }) : salah = salah ?? Salah.empty;

  final SalahStatus status;
  final CurrentSalah currentSalah;
  final NextSalah nextSalah;

  final Salah salah;

  SalahState copyWith({
    SalahStatus? status,
    Salah? salah,
    CurrentSalah? currentSalah,
    NextSalah? nextSalah,
  }) {
    return SalahState(
      status: status ?? this.status,
      salah: salah ?? this.salah,
      currentSalah: currentSalah ?? this.currentSalah,
      nextSalah: nextSalah ?? this.nextSalah,
    );
  }

  @override
  List<Object?> get props => [status, salah, nextSalah, currentSalah];
}
