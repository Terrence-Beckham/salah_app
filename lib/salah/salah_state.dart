part of 'salah_bloc.dart';

enum SalahStatus { initial, loading, success, failure, athanPlaying }

enum CurrentSalah { Fajr, Sharooq, Dhuhr, Asr, Maghrib, Isha, unknown }

enum NextSalah { Fajr, Sharooq, Dhuhr, Asr, Maghrib, Isha, unknown }

final class SalahBlocState extends Equatable {
  const SalahBlocState({
    this.isAthanTime = false,
    this.timeToNextSalah,
    this.minutesLeft ,
    this.hoursLeft ,
    this.status = SalahStatus.initial,
    Salah? salah,
    this.currentSalah,
    this.nextSalah,
  }) : salah = salah ?? Salah.empty;

  final SalahStatus status;
  final CurrentSalah? currentSalah;
  final NextSalah? nextSalah;
  final int? timeToNextSalah;
  final int? minutesLeft;
  final int? hoursLeft;
  final Salah salah;
  final bool isAthanTime;

  SalahBlocState copyWith({
    SalahStatus Function()? status,
    Salah? Function()? salah,
    CurrentSalah Function()? currentSalah,
    NextSalah Function()? nextSalah,
    int Function()? timeToNextSalah,
    int Function()? minutesLeft,
    int Function()? hoursLeft,
    bool Function()? isAthanTime,
  }) {
    return SalahBlocState(
      status: status != null ? status() : this.status,
      salah: salah != null ? salah() : this.salah,
      currentSalah: currentSalah != null ? currentSalah() : this.currentSalah,
      nextSalah: nextSalah != null ? nextSalah() : this.nextSalah,
      timeToNextSalah:
          timeToNextSalah != null ? timeToNextSalah() : this.timeToNextSalah,
      minutesLeft: minutesLeft != null ? minutesLeft() : this.minutesLeft,
      hoursLeft: hoursLeft != null ? hoursLeft() : this.hoursLeft,
      isAthanTime: isAthanTime != null ? isAthanTime() : this.isAthanTime,
    );
  }

  @override
  List<Object?> get props => [
        status,
        salah,
        nextSalah,
        currentSalah,
        timeToNextSalah,
        minutesLeft,
        hoursLeft,
        isAthanTime,
      ];
}

// class SalahInitial extends SalahState {
//   @override
//   List<Object> get props => [];
// }
