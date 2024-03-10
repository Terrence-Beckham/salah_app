part of 'salah_bloc.dart';

abstract class SalahEvent extends Equatable {
  const SalahEvent();
}

final class SalahInitial extends SalahEvent {
  const SalahInitial();

  @override
  List<Object?> get props => [];
}

final class SubscribeToTimeline extends SalahEvent {
  const SubscribeToTimeline(this.salah);

  final Salah salah;

  @override
  List<Object?> get props => [salah];
}

final class RequestSalah extends SalahEvent {
  const RequestSalah();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}



