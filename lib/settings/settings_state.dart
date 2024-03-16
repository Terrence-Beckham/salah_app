part of 'settings_bloc.dart';

enum SettingsStatus { initial, loading, success, failure }

final class SettingsState extends Equatable {
  const SettingsState({
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
    required this.dhuhrOffset,
    required this.asrOffset,
    required this.maghribOffset,
    required this.ishaOffset,
    this.status = SettingsStatus.initial,
  });

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
  final int dhuhrOffset;
  final int asrOffset;
  final int maghribOffset;
  final int ishaOffset;

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
    int? dhuhrOffset,
    int? asrOffset,
    int? maghribOffset,
    int? ishaOffset,
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
      dhuhrOffset: dhuhrOffset ?? this.dhuhrOffset,
      asrOffset: asrOffset ?? this.asrOffset,
      maghribOffset: maghribOffset ?? this.maghribOffset,
      ishaOffset: ishaOffset ?? this.ishaOffset,
    );
  }

  @override
  List<Object?> get props => [
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
        dhuhrOffset,
        asrOffset,
        maghribOffset,
        ishaOffset,
        ishaOffset,
      ];
}
