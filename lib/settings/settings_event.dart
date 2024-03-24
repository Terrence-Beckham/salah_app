part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

final class SettingsInitial extends SettingsEvent {
  const SettingsInitial({required this.salah});

  final Salah salah;
  @override
  List<Object?> get props => [];
}

final class OffsetIncrement extends SettingsEvent {
  const OffsetIncrement({required this.prayerName});

  final PrayerName prayerName;

  @override
  List<Object?> get props => [prayerName];
}


final class OffsetDecrement extends SettingsEvent {
  const OffsetDecrement({required this.prayerName});

  final PrayerName prayerName;

  @override
  List<Object?> get props => [prayerName];
}
final class SalahTimeLineSubscription extends SettingsEvent {
  const SalahTimeLineSubscription({required Salah salah}) : _salah = salah;


  final Salah _salah;
  @override
  List<Object?> get props => [];

}

