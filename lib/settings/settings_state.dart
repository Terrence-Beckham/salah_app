part of 'settings_bloc.dart';

enum SettingsStatus { initial, loading, success, failure }

final class SettingsState extends Equatable {
  const SettingsState({
    required this.fajrTime,
    required this.fajrOffsetTime,
    required this.sharooqTime,
    required this.sharooqOffsetTime,
    required this.dhuhrTime,
    required this.dhuhrOffsetTime,
    required this.asrTime,
    required this.asrOffsetTime,
    required this.maghribTime,
    required this.maghribOffsetTime,
    required this.ishaTime,
    required this.ishaOffsetTime,
    required this.method,
    required this.language,
    required this.name,
    required this.fajrAthan,
    required this.regularAthan,
    required this.juristicSchool,
    required this.fajrAthanSettings,
    required this.dhuhrAthanSettings,
    required this.asrAthanSettings,
    required this.maghribAthanSettings,
    required this.ishaAthanSettings,
    required this.fajrOffset,
    required this.sharooqOffset,
    required this.dhuhrOffset,
    required this.asrOffset,
    required this.maghribOffset,
    required this.ishaOffset,
    required this.salah,
    this.status = SettingsStatus.initial,
  });

  final Salah salah;
  final SettingsStatus status;
  final int? method;
  final String? language;
  final String name;
  final String fajrAthan;
  final String regularAthan;
  final JuristicSchool juristicSchool;
  final AthanSoundSettings fajrAthanSettings;
  final AthanSoundSettings dhuhrAthanSettings;
  final AthanSoundSettings asrAthanSettings;
  final AthanSoundSettings maghribAthanSettings;
  final AthanSoundSettings ishaAthanSettings;
  final int fajrOffset;
  final int sharooqOffset;
  final int dhuhrOffset;
  final int asrOffset;
  final int maghribOffset;
  final int ishaOffset;

  final String fajrTime;
  final String fajrOffsetTime;
  final String sharooqTime;
  final String sharooqOffsetTime;
  final String dhuhrTime;
  final String dhuhrOffsetTime;
  final String asrTime;
  final String asrOffsetTime;
  final String maghribTime;
  final String maghribOffsetTime;
  final String ishaTime;
  final String ishaOffsetTime;



  SettingsState copyWith({
    SettingsStatus? status,
    int? method,
    String? language,
    String? name,
    String? fajrAthan,
    String? regularAthan,
    JuristicSchool? juristicSchool,
    AthanSoundSettings? fajrAthanSettings,
    AthanSoundSettings? dhuhrAthanSettings,
    AthanSoundSettings? asrAthanSettings,
    AthanSoundSettings? maghribAthanSettings,
    AthanSoundSettings? ishaAthanSettings,
    int? fajrOffset,
    int? sharooqOffset,
    int? dhuhrOffset,
    int? asrOffset,
    int? maghribOffset,
    int? ishaOffset,
    String? fajrTime,
    String? fajrOffsetTime,
    String? sharooqTime,
    String? sharooqOffsetTime,
    String? dhuhrTime,
    String? dhuhrOffsetTime,
    String? asrTime,
    String? asrOffsetTime,
    String? maghribTime,
    String? maghribOffsetTime,
    String? ishaTime,
    String? ishaOffsetTime,
    Salah? salah,
  }) {
    return SettingsState(
      status: status ?? this.status,
      method: method ?? this.method,
      language: language ?? this.language,
      name: name ?? this.name,
      fajrAthan: fajrAthan ?? this.fajrAthan,
      regularAthan: regularAthan ?? this.regularAthan,
      juristicSchool: juristicSchool ?? this.juristicSchool,
      fajrAthanSettings: fajrAthanSettings ?? this.fajrAthanSettings,
      dhuhrAthanSettings: dhuhrAthanSettings ?? this.dhuhrAthanSettings,
      asrAthanSettings: asrAthanSettings ?? this.asrAthanSettings,
      maghribAthanSettings: maghribAthanSettings ?? this.maghribAthanSettings,
      ishaAthanSettings: ishaAthanSettings ?? this.ishaAthanSettings,
      fajrOffset: fajrOffset ?? this.fajrOffset,
      sharooqOffset: sharooqOffset ?? this.sharooqOffset,
      dhuhrOffset: dhuhrOffset ?? this.dhuhrOffset,
      asrOffset: asrOffset ?? this.asrOffset,
      maghribOffset: maghribOffset ?? this.maghribOffset,
      ishaOffset: ishaOffset ?? this.ishaOffset,
      fajrTime: fajrTime ?? this.fajrTime,
      fajrOffsetTime: fajrOffsetTime ?? this.fajrOffsetTime,
      sharooqTime: sharooqTime ?? this.sharooqTime,
      sharooqOffsetTime: sharooqOffsetTime ?? this.sharooqOffsetTime,
      dhuhrTime: dhuhrTime ?? this.dhuhrTime,
      dhuhrOffsetTime: dhuhrOffsetTime ?? this.dhuhrOffsetTime,
      asrTime: asrTime ?? this.asrTime,
      asrOffsetTime: asrOffsetTime ?? this.asrOffsetTime,
      maghribTime: maghribTime ?? this.maghribTime,
      maghribOffsetTime: maghribOffsetTime ?? this.maghribOffsetTime,
      ishaTime: ishaTime ?? this.ishaTime,
      ishaOffsetTime: ishaOffsetTime ?? this.ishaOffsetTime,
      salah: salah ?? this.salah,
    );
  }

  @override
  List<Object?> get props => [
        status,
        salah,
        method,
        language,
        name,
        fajrAthan,
        regularAthan,
        juristicSchool,
        fajrAthanSettings,
        dhuhrAthanSettings,
        asrAthanSettings,
        maghribAthanSettings,
        ishaAthanSettings,
        fajrOffset,
        sharooqOffset,
        dhuhrOffset,
        asrOffset,
        maghribOffset,
        ishaOffset,
        fajrTime,
        fajrOffsetTime,
        sharooqTime,
        sharooqOffsetTime,
        dhuhrTime,
        dhuhrOffsetTime,
        asrTime,
        asrOffsetTime,
        maghribTime,
        maghribOffsetTime,
        ishaTime,
        ishaOffsetTime,
      ];
}
